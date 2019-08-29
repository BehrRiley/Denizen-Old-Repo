"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const languageClient = require("vscode-languageclient");
const path = require("path");
const fs = require("fs");
const util_1 = require("util");
const languageServerPath = "server/DenizenLangServer.dll";
const configuration = vscode.workspace.getConfiguration();
function activateLanguageServer(context) {
    let pathFile = context.asAbsolutePath(languageServerPath);
    if (!fs.existsSync(pathFile)) {
        return;
    }
    let pathDir = path.dirname(pathFile);
    let serverOptions = {
        run: { command: "dotnet", args: [pathFile], options: { cwd: pathDir } },
        debug: { command: "dotnet", args: [pathFile, "--debug"], options: { cwd: pathDir } }
    };
    let clientOptions = {
        documentSelector: ["denizenscript"],
        synchronize: {
            configurationSection: "DenizenLangServer",
        },
    };
    let client = new languageClient.LanguageClient("DenizenLangServer", "Denizen Language Server", serverOptions, clientOptions);
    let disposable = client.start();
    context.subscriptions.push(disposable);
}
const highlightDecors = {};
function colorSet(name, incolor) {
    const colorSplit = incolor.split('\|');
    let resultColor = { color: colorSplit[0] };
    for (const i in colorSplit) {
        const subValueSplit = colorSplit[i].split('=', 2);
        const subValueSetting = subValueSplit[0];
        if (subValueSetting == "style") {
            resultColor.fontStyle = subValueSplit[1];
        }
        else if (subValueSetting == "background") {
            resultColor.backgroundColor = subValueSplit[1];
        }
    }
    highlightDecors[name] = vscode.window.createTextEditorDecorationType(resultColor);
}
const colorTypes = [
    "comment_header", "comment_normal", "comment_code", "comment_1", "comment_2", "comment_3", "comment_4", 
    "key", "key_inline", "command", "quote_double", "quote_single",
    "tag", "tag_dot", "tag_param", "bad_space", "colons", "normal"
];
function activateHighlighter(context) {
    for (const i in colorTypes) {
        let str = configuration.get("denizenscript.theme_colors." + colorTypes[i]);
        if (util_1.isUndefined(str)) {
            console.log("Missing color config for " + colorTypes[i]);
            continue;
        }
        colorSet(colorTypes[i], str);
    }
}
let refreshTimer = undefined;
function refreshDecor() {
    console.log('Denizen extension refreshing');
    refreshTimer = undefined;
    for (const editor of vscode.window.visibleTextEditors) {
        const uri = editor.document.uri.toString();
        if (!uri.endsWith(".dsc")) {
            continue;
        }
        decorateFullFile(editor);
    }
}
function addDecor(decorations, type, lineNumber, startChar, endChar) {
    decorations[type].push(new vscode.Range(new vscode.Position(lineNumber, startChar), new vscode.Position(lineNumber, endChar)));
}
function decorateTag(tag, start, lineNumber, decorations) {
    const len = tag.length;
    let inTagCounter = 0;
    let tagStart = 0;
    let inTagParamCounter = 0;
    let defaultDecor = "tag";
    let lastDecor = -1; // Color the < too.
    for (let i = 0; i < len; i++) {
        const c = tag.charAt(i);
        if (c == '<') {
            inTagCounter++;
            if (inTagCounter == 1) {
                addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + i);
                lastDecor = i;
                defaultDecor = "tag";
                tagStart = i;
            }
        }
        else if (c == '>' && inTagCounter > 0) {
            inTagCounter--;
            if (inTagCounter == 0) {
                decorateTag(tag.substring(tagStart + 1, i), start + tagStart + 1, lineNumber, decorations);
                addDecor(decorations, "tag", lineNumber, start + i, start + i + 1);
                defaultDecor = inTagParamCounter > 0 ? "tag_param" : "tag";
                lastDecor = i + 1;
            }
        }
        else if (c == '[' && inTagCounter == 0) {
            inTagParamCounter++;
            if (inTagParamCounter == 1) {
                addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + i);
                lastDecor = i;
                defaultDecor = "tag_param";
            }
        }
        else if (c == ']' && inTagCounter == 0) {
            inTagParamCounter--;
            if (inTagParamCounter == 0) {
                addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + i + 1);
                defaultDecor = "tag";
                lastDecor = i + 1;
            }
        }
        else if (c == '.' && inTagParamCounter == 0) {
            addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + i);
            lastDecor = i + 1;
            addDecor(decorations, "tag_dot", lineNumber, start + i, start + i + 1);
        }
    }
    if (lastDecor < len) {
        addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + len);
    }
}
function decorateArg(arg, start, lineNumber, decorations) {
    const len = arg.length;
    let quoted = false;
    let quoteMode = 'x';
    let inTagCounter = 0;
    let tagStart = 0;
    let defaultDecor = "normal";
    let lastDecor = 0;
    for (let i = 0; i < len; i++) {
        const c = arg.charAt(i);
        if (c == '"' || c == '\'') {
            if (quoted && c == quoteMode) {
                addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + i + 1);
                lastDecor = i + 1;
                defaultDecor = "normal";
                quoted = false;
            }
            else if (!quoted) {
                addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + i);
                lastDecor = i;
                quoted = true;
                defaultDecor = c == '"' ? "quote_double" : "quote_single";
                quoteMode = c;
            }
        }
        else if (c == '<') {
            inTagCounter++;
            if (inTagCounter == 1) {
                addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + i);
                lastDecor = i;
                tagStart = i;
                defaultDecor = "tag";
            }
        }
        else if (c == '>' && inTagCounter > 0) {
            inTagCounter--;
            if (inTagCounter == 0) {
                decorateTag(arg.substring(tagStart + 1, i), start + tagStart + 1, lineNumber, decorations);
                addDecor(decorations, "tag", lineNumber, start + i, start + i + 1);
                defaultDecor = quoted ? (quoteMode == '"' ? "quote_double" : "quote_single") : "normal";
                lastDecor = i + 1;
            }
        }
        else if (c == ' ' && !quoted) {
            inTagCounter = 0;
            defaultDecor = "normal";
        }
    }
    if (lastDecor < len) {
        addDecor(decorations, defaultDecor, lineNumber, start + lastDecor, start + len);
    }
}
function decorateLine(line, lineNumber, decorations) {
    if (line.endsWith("\r")) {
        line = line.substring(0, line.length - 1);
    }
    const trimmedEnd = line.trimRight();
    const trimmed = trimmedEnd.trimLeft();
    if (trimmed.length == 0) {
        return;
    }
    if (trimmedEnd.length != line.length) {
        addDecor(decorations, "bad_space", lineNumber, trimmedEnd.length, line.length);
    }
    const preSpaces = trimmedEnd.length - trimmed.length;
    if (trimmed.startsWith("#")) {
        const afterComment = trimmed.substring(1).trim();
        if (afterComment.startsWith("|") || afterComment.startsWith("+") || afterComment.startsWith("=")
            || afterComment.startsWith("#") || afterComment.startsWith("_")
            || afterComment.startsWith("/")) {
            addDecor(decorations, "comment_header", lineNumber, preSpaces, line.length);
        }
        else if (afterComment.startsWith("-")) {
            addDecor(decorations, "comment_code", lineNumber, preSpaces, line.length);
        }
        else if (afterComment.startsWith("@")) {
            addDecor(decorations, "comment_1", lineNumber, preSpaces, line.length);
        }
        else if (afterComment.startsWith("$")) {
            addDecor(decorations, "comment_2", lineNumber, preSpaces, line.length);
        }
        else if (afterComment.startsWith("%")) {
            addDecor(decorations, "comment_3", lineNumber, preSpaces, line.length);
        }
        else if (afterComment.startsWith("^")) {
            addDecor(decorations, "comment_4", lineNumber, preSpaces, line.length);
        }
        else {
            addDecor(decorations, "comment_normal", lineNumber, preSpaces, line.length);
        }
    }
    else if (trimmed.startsWith("-")) {
        addDecor(decorations, "normal", lineNumber, preSpaces, preSpaces + 1);
        let afterDash = trimmed.substring(1);
        const commandEnd = afterDash.indexOf(' ', 1) + 1;
        const endIndexCleaned = commandEnd == 0 ? line.length : (preSpaces + commandEnd);
        if (!afterDash.startsWith(" ")) {
            addDecor(decorations, "bad_space", lineNumber, preSpaces + 1, endIndexCleaned);
            decorateArg(trimmed.substring(commandEnd), preSpaces + commandEnd, lineNumber, decorations);
        }
        else {
            afterDash = afterDash.substring(1);
            if (afterDash.startsWith("'") || afterDash.startsWith("\"")) {
                decorateArg(trimmed.substring(2), preSpaces + 2, lineNumber, decorations);
            }
            else {
                addDecor(decorations, "command", lineNumber, preSpaces + 2, endIndexCleaned);
                if (commandEnd > 0) {
                    decorateArg(trimmed.substring(commandEnd), preSpaces + commandEnd, lineNumber, decorations);
                }
            }
        }
    }
    else if (trimmed.endsWith(":")) {
        addDecor(decorations, "key", lineNumber, preSpaces, trimmedEnd.length - 1);
        addDecor(decorations, "colons", lineNumber, trimmedEnd.length - 1, trimmedEnd.length);
    }
    else if (trimmed.includes(":")) {
        const colonIndex = line.indexOf(':');
        addDecor(decorations, "key", lineNumber, preSpaces, colonIndex);
        addDecor(decorations, "colons", lineNumber, colonIndex, colonIndex + 1);
        decorateArg(trimmed.substring(colonIndex - preSpaces + 1), colonIndex + 1, lineNumber, decorations);
    }
    else {
        addDecor(decorations, "bad_space", lineNumber, preSpaces, line.length);
    }
}
function decorateFullFile(editor) {
    let decorations = {};
    for (const c in highlightDecors) {
        decorations[c] = [];
    }
    const fullText = editor.document.getText();
    const splitText = fullText.split('\n');
    const totalLines = splitText.length;
    for (let i = 0; i < totalLines; i++) {
        decorateLine(splitText[i], i, decorations);
    }
    for (const c in decorations) {
        editor.setDecorations(highlightDecors[c], decorations[c]);
    }
}
function scheduleRefresh() {
    if (refreshTimer) {
        return;
    }
    refreshTimer = setTimeout(refreshDecor, 50);
}
function activate(context) {
    activateLanguageServer(context);
    activateHighlighter(context);
    vscode.workspace.onDidOpenTextDocument(doc => {
        if (doc.uri.toString().endsWith(".dsc")) {
            scheduleRefresh();
        }
    }, null, context.subscriptions);
    vscode.workspace.onDidChangeTextDocument(event => {
        if (event.document.uri.toString().endsWith(".dsc")) {
            scheduleRefresh();
        }
    }, null, context.subscriptions);
    vscode.window.onDidChangeVisibleTextEditors(editors => {
        scheduleRefresh();
    }, null, context.subscriptions);
    scheduleRefresh();
    console.log('Denizen extension has been activated');
}
exports.activate = activate;
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map