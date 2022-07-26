// Returning time formatted as in 'server.log' file from default G2O server.
//
// @param string t    Value returned from "date" System library's function
function g2oStyleFormattedDateTime(t) {
    if (t.day < 10) {
        t.day = "0" + t.day;
    }
    t.month += 1; // Numbers represents month starts from '0'.
    if (t.month < 10) {
        t.month = "0" + t.month;
    }
    if (t.hour < 10) {
        t.hour = "0" + t.hour;
    }
    if (t.min < 10) {
        t.min = "0" + t.min;
    }
    if (t.sec < 10) {
        t.sec = "0" + t.sec;
    }
    return "[" + t.year + "-" + t.month + "-" + t.day + " " + t.hour + ":" + t.min + ":" + t.sec + "] "
}

function logMsg (msg, fileName) {
    local datetime = g2oStyleFormattedDateTime(date());
    system ("echo " + datetime + msg + " >> " + fileName);
}

function logError (msg) {
    logMsg (msg, "error_c.log");
}

function logNotice (msg) {
    logMsg (msg, "notice_c.log");
}