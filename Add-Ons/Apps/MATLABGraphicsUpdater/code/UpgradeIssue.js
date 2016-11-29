// JScript source code

//  Copyright 2014 The MathWorks, Inc.

function UpgradeIssue(Issue, Impact, Count, Details, AutoFix,NumFixes, FixType) {
this.Issue = Issue;
this.Impact = Impact;
this.Count = Count;
this.Details = Details;
this.AutoFix = AutoFix;
this.NumFixes = NumFixes;
this.FixType = FixType;

//methods
this.createOption = createOption;
this.createSummaryRow = createSummaryRow;

function createOption() {
var opt = document.createElement("option");
opt.id = this.Impact;

opt.value = this.Issue;
opt.innerHTML = this.Issue + " (" + this.Count + ")";

return opt;
}


function createSummaryRow(isGraphicsUpdater) {

        var table = document.getElementById("MessageSummaryTable");

        var row = table.insertRow(-1);
        var cell = row.insertCell(0);
        var innerHTML;
        // add first column
        row.id = this.Issue;
        innerHTML = '<a class="' + this.Impact + '">' + this.Issue + '</a><a>   </a>';
        if (this.Count > 1) {
            innerHTML = innerHTML + '<button class="view" id="' + this.Issue + '" onClick="Upgrader.viewIssues(this);">View all ' + this.Count + ' instances</button>';
        }

        if (this.FixType=="full") {
            innerHTML = innerHTML + '<br><a class="FixColor">Fix available. </a>';
        } else if (this.FixType=="manual") {
            innerHTML = innerHTML + '<br><a class="ManualColor">Manual changes required. </a>';
        } else if (this.FixType=="part") {
            innerHTML = innerHTML + '<br><a class="FixColor">Partial fix available. Further manual changes required. </a>';
        }
        innerHTML = innerHTML + '<br><br><a>' + this.Details + '</a>';
        if (isGraphicsUpdater) {
            // help link to transition page
            innerHTML = innerHTML + '<br><a>For more information, see </a><a href="' + 'matlab:web(fullfile(docroot,' + "'matlab','graphics-changes-in-r2014b.html'" + '))">Graphics Changes in R2014b</button><a>.</a>';
        }
        cell.innerHTML = innerHTML;
        cell.style.borderStyle = "none";
        row.style.borderStyle = "none";
    // help is shown when selected (see showHelp)
        row.style.display = "none";


}


}

// Javascript mouse events for drag and drop
function onStartDrag(obj, event) {
    DragWindow = document.getElementById('SummarySection');
    offsetX = event.clientX-parseInt(DragWindow.style.left);
    offsetY = event.clientY-parseInt(DragWindow.style.top);
    document.onmouseup = onFinishDrag;
    document.onmousemove = onDrag;

    DragTitle = obj;
    CurrentCursor = DragTitle.style.cursor;
    DragTitle.style.cursor = "move";

}

function onDrag(event) {

    var x = document.all ? window.event.clientX : event.pageX;
    var y = document.all ? window.event.clientY : event.pageY;
    DragWindow.style.left = (x - offsetX) + "px";
    DragWindow.style.top = (y - offsetY) + "px";

}



function onFinishDrag(event) {
    onDrag(event);
    DragTitle.style.cursor = CurrentCursor;
    document.onmouseup = null;
    document.onmousemove = null;


}
