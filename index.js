/* eslint-disable no-undef */
chrome.contextMenus.onClicked.addListener((info, tab) => {
    const cardNumber = info.menuItemId.trim().replace(' ', '');

    /**
     *
     * @param text
     */
    function copyClipboard(text) {
        const textarea = document.createElement('textarea');
        textarea.value = text;

        document.body.appendChild(textarea);
        textarea.select();

        document.execCommand('copy');

        document.body.removeChild(textarea);
    }

    /* eslint-disable no-undef */
    chrome.scripting.executeScript({
        target: { tabId: tab.id },
        func: copyClipboard,
        args: [cardNumber],
    });
});

chrome.runtime.onInstalled.addListener(function () {
    const cards = [
        { cardNumber: '3782 822463 10005', name: 'American Express' },
        { cardNumber: '2223 0000 1047 9399', name: 'Mastercard' },
        { cardNumber: '4543 4740 0224 9996', name: 'VISA' },
        { cardNumber: '4242 4242 4242 4242', name: 'Non 3DS' },
    ];

    const contexts = ['page', 'selection', 'link', 'editable', 'image', 'video', 'audio'];

    chrome.contextMenus.create({
        id: 'mollie',
        title: 'Mollie Payments',
        type: 'normal',
        contexts: contexts,
    });

    chrome.contextMenus.create({
        id: 'testcards',
        title: 'Test Cards (copy to clipboard)',
        parentId: 'mollie',
        type: 'normal',
        contexts: contexts,
    });

    cards.forEach((card) => {
        chrome.contextMenus.create({
            id: card.cardNumber,
            title: `${card.name} (${card.cardNumber})`,
            parentId: 'testcards',
            type: 'normal',
            contexts: contexts,
        });
    });
});
