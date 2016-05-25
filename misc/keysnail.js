// ========================== KeySnail Init File =========================== //

// You can preserve your code in this area when generating the init file using GUI.
// Put all your code except special key, set*key, hook, blacklist.
// ========================================================================= //
//{{%PRESERVE%
// ここにコードを入力して下さい
//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "C-g";
key.helpKey              = "<f1>";
key.escapeKey            = "C-q";
key.macroStartKey        = "Not defined";
key.macroEndKey          = "Not defined";
key.universalArgumentKey = "C-u";
key.negativeArgument1Key = "C--";
key.negativeArgument2Key = "C-M--";
key.negativeArgument3Key = "M--";
key.suspendKey           = "<f2>";

// ================================= Hooks ================================= //

hook.setHook('KeyBoardQuit', function (aEvent) {
    if (key.currentKeySequence.length) {
        return;
    }
    command.closeFindBar();
    if (util.isCaretEnabled()) {
        command.resetMark(aEvent);
    } else {
        goDoCommand("cmd_selectNone");
    }
    key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_ESCAPE, true);
});

hook.setHook('Unload', function () {
    gBrowser.removeProgressListener(KeySnail.urlBarListener);
});
hook.addToHook('Unload', function () {
    util.setUnicharPref(allowedEventsKey, allowedEvents);
});
hook.addToHook('Unload', function () {
    gBrowser.removeProgressListener(KeySnail.urlBarListener);
});


// ============================= Key bindings ============================== //

key.setGlobalKey('C-M-r', function () {
    userscript.reload();
}, '設定ファイルを再読み込み', true);

key.setGlobalKey('M-x', function (aEvent, aArg) {
    ext.select(aArg, aEvent);
}, 'エクステ', true);

key.setGlobalKey('M-:', function () {
    command.interpreter();
}, 'コマンドインタプリタ', true);

key.setGlobalKey(['<f1>', 'b'], function () {
    key.listKeyBindings();
}, 'キーバインド一覧を表示');

key.setGlobalKey(['<f1>', 'F'], function () {
    openHelpLink("firefox-help");
}, 'Firefox のヘルプを表示');

key.setGlobalKey('C-m', function (aEvent) {
    hah.enterStartKey(aEvent);
}, 'LoL を開始');

key.setGlobalKey(['C-x', 'l'], function () {
    command.focusToById("urlbar");
}, 'ロケーションバーへフォーカス', true);

key.setGlobalKey(['C-x', 'g'], function () {
    command.focusToById("searchbar");
}, '検索バーへフォーカス', true);

key.setGlobalKey(['C-x', 't'], function () {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, '最初のインプットエリアへフォーカス', true);

key.setGlobalKey(['C-x', 's'], function () {
    command.focusElement(command.elementsRetrieverButton, 0);
}, '最初のボタンへフォーカス', true);

key.setGlobalKey(['C-x', 'k'], function () {
    BrowserCloseTabOrWindow();
}, 'タブ / ウィンドウを閉じる');

key.setGlobalKey(['C-x', 'K'], function () {
    closeWindow(true);
}, 'ウィンドウを閉じる');

key.setGlobalKey(['C-x', 'n'], function () {
    OpenBrowserWindow();
}, 'ウィンドウを開く');

key.setGlobalKey(['C-x', 'C-c'], function () {
    goQuitApplication();
}, 'Firefox を終了', true);

key.setGlobalKey(['C-x', 'o'], function (aEvent, aArg) {
    command.focusOtherFrame(aArg);
}, '次のフレームを選択');

key.setGlobalKey(['C-x', '1'], function (aEvent) {
    window.loadURI(aEvent.target.ownerDocument.location.href);
}, '現在のフレームだけを表示', true);

key.setGlobalKey(['C-x', 'C-f'], function () {
    BrowserOpenFileWindow();
}, 'ファイルを開く', true);

key.setGlobalKey(['C-x', 'C-s'], function () {
    saveDocument(window.content.document);
}, 'ファイルを保存', true);

key.setGlobalKey('M-w', function (aEvent) {
    command.copyRegion(aEvent);
}, '選択中のテキストをコピー', true);

key.setGlobalKey('C-s', function () {
    command.iSearchForward();
}, 'インクリメンタル検索', true);

key.setGlobalKey('C-r', function () {
    command.iSearchBackward();
}, '逆方向インクリメンタル検索', true);

key.setGlobalKey(['C-c', 'u'], function () {
    undoCloseTab();
}, '閉じたタブを元に戻す');

key.setGlobalKey(['C-c', 'C-c', 'C-v'], function () {
    toJavaScriptConsole();
}, 'Javascript コンソールを表示', true);

key.setGlobalKey(['C-c', 'C-c', 'C-c'], function () {
    command.clearConsole();
}, 'Javascript コンソールの表示をクリア', true);

key.setGlobalKey(['C-c', 'j'], function (ev) {
    var browser = getBrowser();
    if (browser.mCurrentTab.previousSibling) {
        browser.moveTabTo(browser.mCurrentTab, browser.mCurrentTab._tPos - 1);
    } else {
        browser.moveTabTo(browser.mCurrentTab, browser.mTabContainer.childNodes.length - 1);
    }
}, 'Move selected tab to left');

key.setGlobalKey(['C-c', 'f'], function (ev) {
    var browser = getBrowser();
    if (browser.mCurrentTab.nextSibling) {
        browser.moveTabTo(browser.mCurrentTab, browser.mCurrentTab._tPos + 1);
    } else {
        browser.moveTabTo(browser.mCurrentTab, 0);
    }
}, 'Move selected tab to right');

key.setGlobalKey(['C-c', 'd'], function (ev, arg) {
    var orgTab = gBrowser.mCurrentTab;
    var newTab = gBrowser.duplicateTab(orgTab);
    gBrowser.moveTabTo(newTab, orgTab._tPos + 1);
}, 'Duplicate Tab');

key.setGlobalKey(['C-H', 'a'], function (ev, arg) {
    ext.exec("hateb-bookmark-this-page", arg, ev);
}, 'Add this page to the hatena bookmark', true);

key.setGlobalKey(['C-H', 'l'], function (ev, arg) {
    ext.exec("list-hateb-items", arg, ev);
}, 'List all hatena bookmark entries in prompt.selector', true);

key.setGlobalKey(['C-H', 'c'], function (ev, arg) {
    ext.exec("list-hateb-comments", arg, ev);
}, 'List hatena bookmark comments of this page', true);

key.setGlobalKey(['C-c', 'C-j'], function () {
    gBrowser.mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ');

key.setGlobalKey(['C-c', 'C-k'], function () {
    gBrowser.mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ');

key.setGlobalKey('M-b', function (ev, arg) {
    ext.exec("bmany-list-bookmarks-with-keyword", arg, ev);
}, 'bmany - List bookmarks with keyword', true);

key.setGlobalKey('C-t', function (ev, arg) {
    ext.exec("hok-start-extended-mode", arg, ev);
}, 'Start Hit a Hint extended mode', true);

key.setGlobalKey('C-;', function () {
    document.getElementById("cmd_newNavigatorTab").doCommand();
}, 'タブを開く');

key.setGlobalKey('M-o', function (ev, arg) {
    ext.exec("hok-start-foreground-mode", arg, ev);
}, 'Start Hit a Hint foreground mode', true);

key.setGlobalKey('C-o', function (ev, arg) {
    ext.exec("hok-start-background-mode", arg, ev);
}, 'Start Hit a Hint background mode', true);

key.setGlobalKey('C-M-o', function (ev, arg) {
    ext.exec("hok-start-continuous-mode", arg, ev);
}, 'Start Hit a Hint continuous mode', true);

key.setViewKey([['C-n'], ['j']], function (aEvent) {
    key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_DOWN, true);
}, '一行スクロールダウン');

key.setViewKey([['C-p'], ['k']], function (aEvent) {
    key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_UP, true);
}, '一行スクロールアップ');

key.setViewKey([['M-f'], ['.']], function (aEvent) {
    key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_LEFT, true);
}, '左へスクロール');

key.setViewKey([['M-j'], [',']], function (aEvent) {
    key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_RIGHT, true);
}, '右へスクロール');

key.setViewKey([['M-v'], ['b']], function () {
    goDoCommand("cmd_scrollPageUp");
}, '一画面分スクロールアップ');

key.setViewKey('C-v', function () {
    goDoCommand("cmd_scrollPageDown");
}, '一画面スクロールダウン');

key.setViewKey([['M-<'], ['g']], function () {
    goDoCommand("cmd_scrollTop");
}, 'ページ先頭へ移動', true);

key.setViewKey([['M->'], ['G']], function () {
    goDoCommand("cmd_scrollBottom");
}, 'ページ末尾へ移動', true);

key.setViewKey('R', function () {
    BrowserReload();
}, '更新', true);

key.setViewKey('B', function () {
    BrowserBack();
}, '戻る');

key.setViewKey('F', function () {
    BrowserForward();
}, '進む');

key.setViewKey(['C-x', 'h'], function () {
    goDoCommand("cmd_selectAll");
}, 'すべて選択', true);

key.setViewKey('f', function () {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, '最初のインプットエリアへフォーカス', true);

key.setViewKey('M-p', function () {
    command.walkInputElement(command.elementsRetrieverButton, true, true);
}, '次のボタンへフォーカスを当てる');

key.setViewKey('M-n', function () {
    command.walkInputElement(command.elementsRetrieverButton, false, true);
}, '前のボタンへフォーカスを当てる');

key.setEditKey([['C-SPC'], ['C-@']], function (aEvent) {
    command.setMark(aEvent);
}, 'マークをセット', true);

key.setEditKey('C-o', function (aEvent) {
    command.openLine(aEvent);
}, '行を開く (Open line)');

key.setEditKey([['C-x', 'u'], ['C-_']], function () {
    display.echoStatusBar("Undo!", 2000);
    goDoCommand("cmd_undo");
}, 'アンドゥ');

key.setEditKey(['C-x', 'r', 'd'], function (aEvent, aArg) {
    command.replaceRectangle(aEvent.originalTarget, "", false, !aArg);
}, '矩形削除', true);

key.setEditKey(['C-x', 'r', 't'], function (aEvent) {
    prompt.read("String rectangle: ", function (aStr, aInput) {command.replaceRectangle(aInput, aStr);}, aEvent.originalTarget);
}, '矩形置換', true);

key.setEditKey(['C-x', 'r', 'o'], function (aEvent) {
    command.openRectangle(aEvent.originalTarget);
}, '矩形行空け', true);

key.setEditKey(['C-x', 'r', 'k'], function (aEvent, aArg) {
    command.kill.buffer = command.killRectangle(aEvent.originalTarget, !aArg);
}, '矩形キル', true);

key.setEditKey(['C-x', 'r', 'y'], function (aEvent) {
    command.yankRectangle(aEvent.originalTarget, command.kill.buffer);
}, '矩形ヤンク', true);

key.setEditKey('C-\\', function () {
    display.echoStatusBar("Redo!", 2000);
    goDoCommand("cmd_redo");
}, 'リドゥ');

key.setEditKey('C-a', function (aEvent) {
    command.beginLine(aEvent);
}, '行頭へ移動');

key.setEditKey('C-e', function (aEvent) {
    command.endLine(aEvent);
}, '行末へ');

key.setEditKey('C-f', function (aEvent) {
    command.nextChar(aEvent);
}, '一文字右へ移動');

key.setEditKey('M-j', function (aEvent) {
    command.previousWord(aEvent);
}, '一単語左へ移動');

key.setEditKey('M-f', function (aEvent) {
    command.nextWord(aEvent);
}, '一単語右へ移動');

key.setEditKey('C-n', function (aEvent) {
    command.nextLine(aEvent);
}, '一行下へ');

key.setEditKey('C-p', function (aEvent) {
    command.previousLine(aEvent);
}, '一行上へ');

key.setEditKey('C-v', function (aEvent) {
    command.pageDown(aEvent);
}, '一画面分下へ');

key.setEditKey('M-v', function (aEvent) {
    command.pageUp(aEvent);
}, '一画面分上へ');

key.setEditKey('M-<', function (aEvent) {
    command.moveTop(aEvent);
}, 'テキストエリア先頭へ');

key.setEditKey('M->', function (aEvent) {
    command.moveBottom(aEvent);
}, 'テキストエリア末尾へ');

key.setEditKey('C-d', function () {
    goDoCommand("cmd_deleteCharForward");
}, '次の一文字削除');

key.setEditKey('C-h', function () {
    goDoCommand("cmd_deleteCharBackward");
}, '前の一文字を削除');

key.setEditKey('M-d', function () {
    goDoCommand("cmd_deleteWordForward");
}, '次の一単語を削除');

key.setEditKey([['C-<backspace>'], ['M-<delete>']], function () {
    goDoCommand("cmd_deleteWordBackward");
}, '前の一単語を削除');

key.setEditKey('M-u', function (aEvent) {
    command.processForwardWord(aEvent.originalTarget, function (aString) {return aString.toUpperCase();});
}, '次の一単語を全て大文字に (Upper case)');

key.setEditKey('M-l', function (aEvent) {
    command.processForwardWord(aEvent.originalTarget, function (aString) {return aString.toLowerCase();});
}, '次の一単語を全て小文字に (Lower case)');

key.setEditKey('M-c', function (aEvent) {
    command.processForwardWord(aEvent.originalTarget, command.capitalizeWord);
}, '次の一単語をキャピタライズ');

key.setEditKey('C-k', function (aEvent) {
    command.killLine(aEvent);
}, 'カーソルから先を一行カット (Kill line)');

key.setEditKey('C-y', command.yank, '貼り付け (Yank)');

key.setEditKey('M-y', command.yankPop, '古いクリップボードの中身を順に貼り付け (Yank pop)', true);

key.setEditKey('C-M-y', function (aEvent) {
    if (!command.kill.ring.length) {
        return;
    }
    let (ct = command.getClipboardText()) (!command.kill.ring.length || ct != command.kill.ring[0]) &&
        command.pushKillRing(ct);
    prompt.selector({message: "Paste:", collection: command.kill.ring, callback: function (i) {if (i >= 0) {key.insertText(command.kill.ring[i]);}}});
}, '以前にコピーしたテキスト一覧から選択して貼り付け', true);

key.setEditKey('C-w', function (aEvent) {
    goDoCommand("cmd_copy");
    goDoCommand("cmd_delete");
    command.resetMark(aEvent);
}, '選択中のテキストを切り取り (Kill region)', true);

key.setEditKey('M-n', function () {
    command.walkInputElement(command.elementsRetrieverTextarea, true, true);
}, '次のテキストエリアへフォーカス');

key.setEditKey('M-p', function () {
    command.walkInputElement(command.elementsRetrieverTextarea, false, true);
}, '前のテキストエリアへフォーカス');

key.setEditKey('C-j', function (aEvent) {
    command.previousChar(aEvent);
}, '一文字左へ移動');

key.setEditKey('M-h', function (ev) {
    command.deleteBackwardWord(ev);
}, '前の一単語を削除');

key.setEditKey('C-b', function () {
    ;
}, 'No-op', true);

key.setCaretKey([['C-a'], ['^']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectBeginLine") : goDoCommand("cmd_beginLine");
}, 'キャレットを行頭へ移動');

key.setCaretKey([['C-e'], ['$'], ['M->'], ['G']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
}, 'キャレットを行末へ移動');

key.setCaretKey([['C-n'], ['j']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectLineNext") : goDoCommand("cmd_scrollLineDown");
}, 'キャレットを一行下へ');

key.setCaretKey([['C-p'], ['k']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : goDoCommand("cmd_scrollLineUp");
}, 'キャレットを一行上へ');

key.setCaretKey([['C-f'], ['l']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectCharNext") : goDoCommand("cmd_scrollRight");
}, 'キャレットを一文字右へ移動');

key.setCaretKey([['C-j'], ['W']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectWordPrevious") : goDoCommand("cmd_wordPrevious");
}, 'キャレットを一単語左へ移動');

key.setCaretKey([['h'], ['C-h']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectCharPrevious") : goDoCommand("cmd_scrollLeft");
}, 'キャレットを一文字左へ移動');

key.setCaretKey([['M-f'], ['w']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectWordNext") : goDoCommand("cmd_wordNext");
}, 'キャレットを一単語右へ移動');

key.setCaretKey('C-v', function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectPageNext") : goDoCommand("cmd_movePageDown");
}, 'キャレットを一画面分下へ');

key.setCaretKey([['M-v'], ['b']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectPagePrevious") : goDoCommand("cmd_movePageUp");
}, 'キャレットを一画面分上へ');

key.setCaretKey([['M-<'], ['g']], function (aEvent) {
    aEvent.target.ksMarked ? goDoCommand("cmd_selectTop") : goDoCommand("cmd_scrollTop");
}, 'キャレットをページ先頭へ移動');

key.setCaretKey('J', function () {
    util.getSelectionController().scrollLine(true);
}, '画面を一行分下へスクロール');

key.setCaretKey('K', function () {
    util.getSelectionController().scrollLine(false);
}, '画面を一行分上へスクロール');

key.setCaretKey(',', function () {
    util.getSelectionController().scrollHorizontal(true);
    goDoCommand("cmd_scrollLeft");
}, '左へスクロール');

key.setCaretKey('.', function () {
    goDoCommand("cmd_scrollRight");
    util.getSelectionController().scrollHorizontal(false);
}, '右へスクロール');

key.setCaretKey('z', function (aEvent) {
    command.recenter(aEvent);
}, 'キャレットの位置までスクロール');

key.setCaretKey([['C-SPC'], ['C-@']], function (aEvent) {
    command.setMark(aEvent);
}, 'マークをセット', true);

key.setCaretKey('R', function () {
    BrowserReload();
}, '更新', true);

key.setCaretKey('B', function () {
    BrowserBack();
}, '戻る');

key.setCaretKey('F', function () {
    BrowserForward();
}, '進む');

key.setCaretKey(['C-x', 'h'], function () {
    goDoCommand("cmd_selectAll");
}, 'すべて選択', true);

key.setCaretKey('f', function () {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, '最初のインプットエリアへフォーカス', true);

key.setCaretKey('M-p', function () {
    command.walkInputElement(command.elementsRetrieverButton, true, true);
}, '次のボタンへフォーカスを当てる');

key.setCaretKey('M-n', function () {
    command.walkInputElement(command.elementsRetrieverButton, false, true);
}, '前のボタンへフォーカスを当てる');
