const vscode = require('vscode');

function hello() {
    vscode.window.showInformationMessage('bcx/hello');
}

function activate(context) {
    // сообщение в консоль разработчика
    console.log('bcx: activate');
    // сообщение пользователю в правом нижнем углу
    vscode.window.showInformationMessage('bcx: activate');

    // добавить команду, которую пользователь сможет вызвать вручную
    let disposable = vscode.commands.registerCommand('bcx.hello', () => {
        vscode.window.showInformationMessage('bcx.hello');
    });
    context.subscriptions.push(disposable);
}

function deactivate(context) {
    console.log('bcx: deactivate');
}

module.exports = {
    activate,
    deactivate
};
