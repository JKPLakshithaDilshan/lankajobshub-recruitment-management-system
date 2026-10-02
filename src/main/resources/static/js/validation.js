document.addEventListener('DOMContentLoaded', function () {
    var now = new Date();
    now.setSeconds(0, 0);
    var localNow = new Date(now.getTime() - now.getTimezoneOffset() * 60000)
        .toISOString()
        .slice(0, 16);

    document.querySelectorAll('input[type="datetime-local"][data-min-now="true"]').forEach(function (input) {
        input.min = localNow;
    });

    document.querySelectorAll('input[type="number"][data-non-negative="true"]').forEach(function (input) {
        input.min = input.min || '0';
    });
});
