function onSelectOption(event) {
    trace('test');
    if (['Restart Song','Change Options','Exit to charter','Exit to menu'].contains(event.name)) {
        trace('test 2');
        this.close();
    }
}