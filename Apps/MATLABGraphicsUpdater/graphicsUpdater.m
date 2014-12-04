function graphicsUpdater(varargin)
%graphicsUpdater open MATLAB Graphics Updater app
%    The MATLAB Graphics Updater app checks MATLAB files for code that
%    requires updating in order to work with the MATLAB graphics changes
%    introduced in R2014b. It produces an interactive HTML report with a
%    list of possible issues, help dialogs with descriptions of the issues,
%    and the recommended solutions. For some issues, the tool can
%    automatically replace the current code with the recommended solution.
%  
%    graphicsUpdater launches the MATLAB Graphics Updater app.
% 
%    graphicsUpdater(FOLDER) produces a report for all MATLAB files
%    contained in FOLDER and its subfolders. Specify the full path name for
%    the folder.
% 
%    How to use the report:
%    * Backup the folder of MATLAB files using the Backup button. This
%      button creates a zip file containing all files reported in the
%      specified folder and its subfolders. 
%    * Review the issues listed in the report. 
%      * For each issue there is a link to view the line of code in the
%        MATLAB Editor, a button to access help about the specific issue, and a
%        snippet of the current code. 
%      * If an automatic fix is available, then a Fix or Partial Fix button
%        appears in addition to a code snippet representing a preview of how
%        the code would be fixed.
%    * Refine the issues displayed within the report. 
%      * Use the High/Medium/Low Impact tabs to view issues that are more or
%        less likely to require a change to your code. For more information on
%        these tabs, see the descriptions below.
%      * Use the Refine by issue pull-down menu to display issues of the same
%        type.
%    * Fix the issues identified in the report. Use the Refresh button to
%      update the table to only include the remaining issues. You must save
%      the file and use the Refresh button in the report for the changes to be
%      accepted.
%      * If an automatic fix is available, you can automatically
%        update your code by clicking the Fix or Partial Fix button in the
%        Issue column. This button opens the code and applies the fix in
%        the MATLAB Editor. After applying the fix, you should verify that
%        the change is correct. To undo the change, use the Undo function
%        on the Quick Access Toolbar in the MATLAB Editor.
%      * For Partial Fixes, there are additional changes you will need to
%        make to your code in addition to the automatic changes made by the
%        tool. Read more about the additional changes required by clicking
%        on the '?' icon next to issue in the table.
%      * If an automatic fix is not available, then you must update the
%        code manually. Read more about the manual changes required by
%        clicking on the '?' icon next to issue in the table. Access the
%        line of code in the MATLAB Editor by following the link in the
%        first column.
%      * You can use the Fix All button at the top of the report to apply the
%        automatic fix for all issues currently displayed in the table that
%        have Fix or Partial Fix buttons associated with them. Review the
%        group of automatic fixes made on the following screen. Click the
%        Undo button to revert the changes or Refresh to accept the
%        changes.
%    * Refresh the report to update the list of messages to reflect the
%      current state of the files in the specified directory.
%  
%    Impact Tabs:
%    The report breaks up the possible issues into different tabs.
%    * The High Impact tab contains issues that graphicsUpdater detects with
%      few false positives.  The problems are severe enough that you are very
%      likely to need to change your code, for example the issue causes an error
%      or warning.
%    * The Medium Impact tab contains issues that graphicsUpdater cannot
%      detect without a significant number of false positives. However, for
%      instances that are correctly detected, you are very likely to need to
%      change your code, again because they may cause an error or warning.
%    * The Low Impact tab contains issues that likely do not require changes
%      to your code, but result in subtle visual or behavioral differences. This
%      category includes messages about optional code cleanup.
%  
%     Disclaimer: The MATLAB Graphics Updater app only detects some of the
%     possible compatibility issues related to updating code for the MATLAB
%     graphics changes introduced in R2014b. You should verify that the automatic
%     changes are appropriate for your code. The best way to verify these
%     changes is to run your code. The automatic changes and suggestions in
%     the report are intended to update code for R2014b and might not run in 
%     releases of MATLAB prior to R2014b.
%
%     It is recommended that you back up your code before using this tool.
%
%     For more information, see <a href="matlab:web(fullfile(docroot, 'matlab/transitioning-to-graphics-version-2.html'))">Graphics Changes in R2014b</a>

%   Copyright 2014 The MathWorks, Inc.

runGraphicsUpdater(varargin{:});

