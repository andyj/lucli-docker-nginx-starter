component output=false {
    this.name = "lucli_test_app";
    this.applicationTimeout = createTimeSpan(1, 0, 0, 0);
    this.sessionManagement = false;

    function onApplicationStart() {
        application.startedAt = now();
        return true;
    }
}
