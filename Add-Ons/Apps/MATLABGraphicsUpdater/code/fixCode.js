

//  Copyright 2014 The MathWorks, Inc.

function fixIssue(obj,Args) {
// call matlab      
runMATLAB("mtcodetools.reviewFix",Args);         
}

function fixAll(Args) {
    // call matlab               
    alert(Args);
runMATLAB("mtcodetools.fix",Args);
}

function refresh(Args) {
// call matlab  
             
runMATLAB("mtcodetools.refresh",Args);
}


function backup(Args) {
// call matlab               

runMATLAB("mtcodetools.backup",Args);
}


function reviewFix(obj,Args) {
// call matlab               
runMATLAB("mtcodetools.reviewFix",Args);
}

function runMATLAB(fcn,Args) {
    // call matlab
    var body = document.getElementsByTagName("body")[0];
    var CurrentStyle = body.style.cursor;
    body.style.cursor = "wait";
    document.location = "matlab:"+fcn+"("+Args+")";
    body.style.cursor = CurrentStyle;
}
