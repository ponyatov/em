const vscode = require('vscode');

function hello() {
    vscode.window.showInformationMessage('bcx/hello');
}

async function activate(context) {
    vscode.window.showInformationMessage('bcx/activate');
    context.subscriptions.push(
        vscode.commands.registerCommand('dponyatov.bcx.hello', hello)
    );
}

function deactivate() {
    vscode.window.showInformationMessage('bcx/deactivate');
}

module.exports = {
    activate,
    deactivate,
    hello,
};
