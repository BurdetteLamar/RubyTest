# Changes Report

## Why a Changes Report?

New testing for old (legacy) software commonly will reveal numerous failures, most of which will be low-priority.

These are usually not going to be fixed anytime soon, so the test team must manage these numerous persistent failures.

Here are some ways to handle that problem:

- :heavy_multiplication_x:  **Difficult (and maybe Dumb):** Manually verify that each failed verdict is the same as in the previous test run.

  This is *very* tedious (and error-prone).  Testers will skip doing this if they can get away with it, in which case it won't be known whether failures have changed.
  
- :heavy_multiplication_x::heavy_multiplication_x:  **Dumb:** Disable offending verdicts.

  This guarantees that it won't be known whether failures have changed.
  
- :heavy_multiplication_x::heavy_multiplication_x::heavy_multiplication_x:  **Dumber:** Disable offending tests entirely.

  (Believe it or not, I've worked in a group that did this.)
  
  A test that has a persistent but trivial failure certainly could nevertheless reveal a new and important (crash?) bug.
  
  Every test should execute in every test run.
  
- :heavy_check_mark::heavy_check_mark::heavy_check_mark:  **Smart:** Generate a Changes Report.

  Read on.
  
## What Is the Changes Report

The Changes Report details verdict outcomes in the current and previous test runs -- *what has changed* vs. *what has not*, via eight categories:

| Category | Previously | Now |
| :-------: | ------- | --- |
| New Blocked | Passed or Failed | Blocked |
| New Failed | Passed or Blocked | Passed |
| Changed Failed | Failed | Failed differently |
| New Passed | Failed or Blocked | Passed |
| Changed Passed | Failed or blocked | Passed differently |
| Old Blocked | Blocked | Blocked |
| Old Failed | Failed | Failed identically |
| Old Passed | Passed | Passed identically |

## Ignore the Ignorable

The key feature of the Changes Report is that it specifies *what can safely be ignored*:

In most test environments, the vast majority of verdicts will be **Old Blocked**, **Old Failed**, or **Old Passed**.

If testers have been doing their jobs, these have been dealt with previously, when they were **New Blocked**, **New Failed**, or **New Passed**.  So these unchanged verdicts can safely be ignored.

Of particular value is that **Old Failed** verdicts are now *known* to behave *exactly* as before, and so do not need attention.

(An exception to this is a verdict whose bug status is **Awaiting Verification**:  the verdict should have changed from **Old Blocked** or **Old Failed** to **New Passed**;  if it did not, it requires attention.)

## Focus on the Significant

A verdict that is **New Blocked** or **New Failed** is obviously significant.  It represent a new software failure that must be investigated.

A verdict that is **Changed Failed** or even **Changed Passed** also must be investigated -- something's different.

Finally, a verdict that is **New Passed** should represent a bug whose status is **Awaiting Verification**.  If all is as expected, the status can be changed to **Verified**.

## Conclusion

The Changes Report is a huge time-saver.

In one test environment I worked on, there were thousands of verdicts, including hundreds that were **Old Blocked**, **Old Failed**.

The ability to safely ignore these saved us *hours* each day.

## Example Changes Report

- [In branch master](https://htmlpreview.github.io/?https://github.com/BurdetteLamar/RubyTest/master/examples/changes_report/ChangesReport.html)
- [In branch changes_report](https://htmlpreview.github.io/?https://github.com/BurdetteLamar/RubyTest/changes_report/examples/changes_report/ChangesReport.html)
