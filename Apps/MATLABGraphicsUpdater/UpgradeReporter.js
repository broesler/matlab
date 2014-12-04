// JScript source code

//  Copyright 2014 The MathWorks, Inc.

function UpgradeReporter(CheckerClass, TimeStamp) {

    this.CheckerClass = CheckerClass;
    this.CurrentImpact = "AllMessages";
    this.CurrentIssue = "All";
    this.TimeStamp = TimeStamp;
    this.Options = null;
    this.IssueList = [];
    this.NumCompleted = 0;

    // methods
    this.addIssue = addIssue;
    this.selectImpact = selectImpact;
    this.updateIssueSelector = updateIssueSelector;
    this.updateFixButton = updateFixButton;
    this.selectIssue = selectIssue;
    this.showHelp = showHelp;
    this.reviewFix = reviewFix;
    this.backup = backup;
    this.fixBatch = fixBatch;
    this.undo = undo;
    this.refresh = refresh;
    this.initImpact = initImpact;
    this.updateTab = updateTab;
    this.selectTab = selectTab;
    this.mouseOverTab = mouseOverTab;
    this.mouseOutTab = mouseOutTab;
    this.help = help;
    this.viewIssues = viewIssues;
    this.selectIssuePulldown = selectIssuePulldown;
    this.closeHelp = closeHelp;
    this.selectRow = selectRow;
    this.markCompleted = markCompleted;
    this.showCompleted = showCompleted;

    function addIssue(Issue, Impact, Count, Details, AutoFix,NumFixes, FixType) {
        // add message to help

        var newIssue = new UpgradeIssue(Issue, Impact, Count, Details, AutoFix, NumFixes, FixType);
        var isGraphicsUpdater = CheckerClass == 'hgupgrade.HGPropertyChecker';
        newIssue.createSummaryRow(isGraphicsUpdater);
        this.IssueList.push(newIssue);

        // add issue to pull down options
        var Selector = document.getElementById("IssueSelector");
        if (Selector!=null) {
            var opt = newIssue.createOption();
            var optGroups = Selector.getElementsByTagName("optgroup");
            for (var i = 0; i < optGroups.length; i++) {
                 if (optGroups[i].id == Impact) {
                     optGroups[i].appendChild(opt);
                     opt.style.display = "inline";
                }
            }
        this.Options = Selector.options;
        }


    }

    function updateTab(thisImpact, Count) {
        // update tab for named impact

        var tab = document.getElementById("MainTab");
        if (tab!=null) {
            var item = tab.childNodes;
            for (var i = 0; i < tab.childNodes.length; i++) {
                if (tab.childNodes[i].id == thisImpact) {
                    item = tab.childNodes[i];
                    break;
                }
            }
            if (Count == 0) {
                // hide tab if there are no issues
                item.style.display = "none";
            } else {
                // display number of issues in tab text
                if (thisImpact != "AllMessages") {
                    item.innerHTML = thisImpact + " Impact (" + Count + ")";
                    var Selector = document.getElementById("IssueSelector");
                    var optGroup = document.createElement('optgroup')
                    optGroup.label = thisImpact + " Impact (" + Count + ")";
                    optGroup.id = thisImpact;
                    Selector.appendChild(optGroup);
                } else {
                    item.innerHTML = "All Issues (" + Count + ")";
                }
            }
       }
            
            
    }

    function initImpact(Impact) {
        // initial impact is to show all

        var obj = document.getElementById(Impact);
        this.selectTab(obj);

    }

    function selectImpact() {
        // select impact from tab


        var doAll = this.CurrentImpact == "AllMessages";
        var tblRows = document.getElementById("CodeReportTable").rows;
        var Count = 0;
        var Completed = true;
        this.NumCompleted = 0;
        // skip the header
        for (var i = 0; i < tblRows.length; i++) {
            // analyse "a" tags in second column of table
            var anchors = tblRows[i].cells[2].getElementsByTagName("a");

            if (doAll) {
                // one <a> </a> for spacing in addition to the tag anchor
                var aCount = anchors.length;
            } else {
                var aCount = 0;
                for (var j = 0; j < anchors.length; j++) {
                    aCount += (anchors[j].className == this.CurrentImpact);
                }
            }
            if (aCount > 0) {
                // display row as normal
                tblRows[i].style.display = "";
                Count += aCount;
                var checkbox = tblRows[i].cells[0].getElementsByTagName("input");
                Completed = Completed && checkbox[0].checked;
                if (checkbox[0].checked) {
                    this.NumCompleted++;
                }

            } else {
                // hide row
                tblRows[i].style.display = "none";
            }
        }
        this.showCompleted();
        var MarkAll = document.getElementById("MarkAllCompleted");
        MarkAll.checked = Completed && Count>0;

        // redo enable disable

        var Selector = document.getElementById("IssueSelector");
        if (Selector != null) {
            // update text at for the 'All Messages' option in pulldown
            var doAll = this.CurrentImpact == "AllMessages";
            if (doAll) {
                Selector.options[0].innerHTML = "All Issues (" + Count + ")";
            } else {
                Selector.options[0].innerHTML = "All " + this.CurrentImpact + " Impact Issues (" + Count + ")";
            }
        } 
        this.updateIssueSelector();
    }


    function selectTab(obj) {
        // update tab for named impact

        this.CurrentImpact = obj.id;
        var tab = document.getElementById("MainTab");
        if (tab != null) {
            // activate tab
            var items = tab.getElementsByTagName("a");
            for (var i = 0; i < items.length; i++) {
                if (items[i].id == this.CurrentImpact) {
                    items[i].className = items[i].id + "Active";
                } else {
                    items[i].className = items[i].id;
                }
            }
        }

        this.selectImpact();
    }

    function mouseOverTab(obj) {

        if (obj.id != this.CurrentImpact) {
            obj.className = obj.id + "Hover";
        }
        obj.style.cursor = "pointer";

    }

    function mouseOutTab(obj) {

        if (obj.id != this.CurrentImpact) {
            obj.className = obj.id;
        }
        obj.style.cursor = "auto";

    }


    function updateIssueSelector() {
        var doAll = this.CurrentImpact == "AllMessages";
        var Selector = document.getElementById("IssueSelector");
        if (Selector != null) {
            // selector doesn't exist on review fix screen
            var optGroups = Selector.getElementsByTagName("optgroup");
            for (var i = 0; i < optGroups.length; i++) {
                var opt = optGroups[i];
                // enable/disabled impact group in refine pulldown
                opt.disabled = !(doAll || opt.id == this.CurrentImpact);

            }
            // select all issues
            var option = Selector.options[0];
            option.selected = true;

            this.CurrentIssue = option.value;
        }


        this.updateFixButton();
        this.closeHelp()

    }


    function selectIssue() {
        // select issue from selected option


        var doAllIssues = this.CurrentIssue == "All";
        var doAllImpacts = this.CurrentImpact == "AllMessages";
        var tblRows = document.getElementById("CodeReportTable").rows;
        var Count = 0;
        var Completed = true;
        this.NumCompleted = 0;
        // skip the header
        for (var i = 0; i < tblRows.length; i++) {
            // look in anchors in second colomn (Tag)
            var anchors = tblRows[i].cells[2].getElementsByTagName("a");

            var aCount = 0;
            for (var j = 0; j < anchors.length; j++) {
            // count number of issues in Tag column   
                aCount += (doAllIssues || (anchors[j].id == this.CurrentIssue)) && 
                          (doAllImpacts || (anchors[j].className == this.CurrentImpact));
            }
            if (aCount > 0) {
                // display row as normal
                tblRows[i].style.display = "";
                Count += aCount;
                var checkbox = tblRows[i].cells[0].getElementsByTagName("input");
                Completed = Completed && checkbox[0].checked;
                if (checkbox[0].checked) {
                    this.NumCompleted ++;
                }
            } else {
                // hide row
                tblRows[i].style.display = "none";
            }
        }
        this.showCompleted();
        var doAllImpacts = this.CurrentImpact == "AllMessages";

        var MarkAll = document.getElementById("MarkAllCompleted");
        MarkAll.checked = Completed && Count>0;

        this.updateFixButton();
        this.closeHelp()
    }

    function countRowIssues(tblRow) {

        var anchors = tblRow.cells[2].getElementsByTagName("a");
        var doAllIssues = this.CurrentIssue == "All";
        var doAllImpacts = this.CurrentImpact == "AllMessages";

        var aCount = 0;
        for (var j = 0; j < anchors.length; j++) {
            // count number of issues in Tag column   
            aCount += (doAllIssues || (anchors[j].id == this.CurrentIssue)) &&
                          (doAllImpacts || (anchors[j].className == this.CurrentImpact));
        }

        return aCount;

    }

    function viewIssues(obj) {
        this.CurrentIssue = obj.id;
        this.selectIssue();

        // Change the issue pulldown selector 
        var Selector = document.getElementById("IssueSelector");
        var optGroups = Selector.getElementsByTagName("optgroup");
        for (var i = 0; i < optGroups.length; i++) {
            var opt = optGroups[i];
            for (var j = 0; j < opt.childNodes.length; j++) {
               if (opt.childNodes[j].value == this.CurrentIssue) {
                   opt.childNodes[j].selected = true;
                   break;
               }
            } 
        }



    }

    function selectIssuePulldown(obj) {
        this.CurrentIssue = obj.value;
        this.selectIssue();

    }

    function closeHelp() {
        var SummarySection = document.getElementById("SummarySection");
        SummarySection.style.display = "none";

    }

    function selectRow(checkbox) {
        // select checkbox to indicate completed
        if (checkbox.checked) {
            this.NumCompleted++;
        } else {
            this.NumCompleted--;
        }
        shadeRow(checkbox);
        this.showCompleted();
    }

    function shadeRow(checkbox) {
    // shade row to indicate completed

        var row = checkbox.parentNode;

        while (row.nodeName != 'TR') {
            row = row.parentNode;
        }

        if (checkbox.checked) {
            // blue background when completed
            row.style.backgroundColor = '#DEEBFA';
        } else {
            // white background when not completed
            row.style.backgroundColor = 'white';
        }

    }

    function markCompleted(checkAll) {
    // mark all visible rows as completed
        var checkAllState = checkAll.checked;
        var tbl = document.getElementById("CodeReportTable");
        var tblRows = tbl.rows;
        for (var i = 0; i < tblRows.length; i++) {
            if (tblRows[i].style.display != 'none') {
                var checkbox = tblRows[i].cells[0].getElementsByTagName("input");
                if (checkbox[0].checked != checkAllState) {
                    // update NumCompleted
                    if (checkbox[0].checked) {
                        this.NumCompleted--;
                    } else {
                        this.NumCompleted++;
                    }
                }
                checkbox[0].checked = checkAllState;
                shadeRow(checkbox[0]);
            }
        }
        this.showCompleted();
    }

    function showCompleted() {
        var c = document.getElementById("TotalCompleted");
        c.innerText = this.NumCompleted + " completed";
    }



    function showHelp(Issue) {

        if (typeof Issue === 'undefined') { Issue = this.CurrentIssue; }
        var SummaryTable = document.getElementById("MessageSummaryTable");
        var SummarySection = document.getElementById("SummarySection");


        this.updateFixButton();

        if (Issue == "All") {
            // show bulleted main help
            SummarySection.style.display = "none";
        } else {

            // show message summary table
            SummarySection.style.display = "inline";
            for (var i = 0; i < SummaryTable.rows.length; i++) {
                var tag = SummaryTable.rows[i].id;
                if (tag == Issue) {
                    // display help for selected issue
                    SummaryTable.rows[i].style.display = "inline";
                } else {
                    SummaryTable.rows[i].style.display = "none";
                }
            }
        }
    }

    function reviewFix(obj,FixArgs) {

        var Args = "'" + this.CheckerClass + "','" + this.TimeStamp + "','" + obj.id + "'," + FixArgs;

        // call matlab      
        runMATLAB("mtcodetools.reviewFix", Args);

        // Find table row
        var row = obj.parentNode;
        while (row.nodeName != 'TR') {
            row = row.parentNode;
        }

        checkbox = row.cells[0].getElementsByTagName("input");
        if (!checkbox[0].checked) {
            // add completed
            this.NumCompleted++;
            this.showCompleted();
        }
        checkbox[0].checked = true;
        shadeRow(checkbox[0]);
                   
    }

    function fixBatch() {
        var Args = "'" + this.CheckerClass + "','" + this.TimeStamp +"','" + this.CurrentIssue + "','" + this.CurrentImpact + "'";
        runMATLAB("mtcodetools.fix", Args);
    }

    function backup() {
        var Args = "'" + this.CheckerClass + "','" + this.TimeStamp + "'";
        runMATLAB("mtcodetools.backup", Args);
    }

    function refresh() {
        var Args = "'" + this.CheckerClass + "','" + this.TimeStamp + "'";
        runMATLAB("mtcodetools.refresh", Args);
    }

    function undo() {
        var Args = "'" + this.CheckerClass + "','" + this.TimeStamp + "'";
        runMATLAB("mtcodetools.undo", Args);
    }

    function help(File) {
        var Args = "'" + File + "'";
        runMATLAB("doc", Args);
    }

    function fixButtonTitle(Total, Description) {
        if (Description == "all") {
            if (Total == 1) {
                return "Apply fix to the instance that has a fix"
            } else {
                return "Apply fixes to the " + Total + " instances that have fixes"
            }
        } else {
            if (Total == 1) {
                return "Apply fix to the " + Description + " instances that has a fix"
            } else {
                return "Apply fixes to the " + Total + " " + Description + " instances that have fixes"
            }
        }
    }

    function updateFixButton() {
        /* update Fix Button*/
        var FixButton = document.getElementById("FixButton");
        var doAllImpacts = this.CurrentImpact == "AllMessages";
        if (FixButton != null) {
            if (this.CurrentIssue == "All") {
                // fixing all issues
                var TotalFixes = 0;

                for (var i = 0; i < this.IssueList.length; i++) {
                    if (doAllImpacts || (this.IssueList[i].Impact == this.CurrentImpact)) {
                        // count total fixes for each issue
                        TotalFixes += this.IssueList[i].NumFixes;
                    }
                }
                if (doAllImpacts) {
                    FixButton.title = fixButtonTitle(TotalFixes, "all");
                } else {
                    FixButton.title = fixButtonTitle(TotalFixes, this.CurrentImpact.toLowerCase() + " impact");
                }
                FixButton.innerText = "Fix all " + "(" + TotalFixes + ")";
                if (TotalFixes > 0) {
                    FixButton.style.display = "inline";
                } else {
                    FixButton.style.display = "none";
                }
            } else {
                var SelectedIssue;
                for (var i = 0; i < this.IssueList.length; i++) {
                    if (this.IssueList[i].Issue == this.CurrentIssue) {
                        SelectedIssue = this.IssueList[i];
                        break;
                    }
                }
                if (SelectedIssue.AutoFix && SelectedIssue.NumFixes > 0) {
                   // display fix button and show number of issues to fix
                    FixButton.style.display = "inline";
                    FixButton.innerText = "Fix all " + "(" + SelectedIssue.NumFixes + ")";
                    FixButton.title = fixButtonTitle(SelectedIssue.NumFixes, this.CurrentIssue);
                } else {
                   // hide fix
                    FixButton.style.display = "none";
                }
            }
        }
    }

}

