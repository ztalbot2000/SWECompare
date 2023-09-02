# SWECompare - Solid Works Equation File Comparison Tool.
<base _target="_self">

<BR><BR>
## Table of Contents
* [**About SWECompare**](#about-swecompare)
* [**How to use SWECompare to compare two equation files**](#how-to-use-swecompare-to-compare-two-equation-files)
* [**How to use SWECompare to find unused variables**](#how-to-use-swecompare-to-find-unused-variables)
* [**License**](#license)

<BR><BR>
## About SWECompare
&nbsp;&nbsp;&nbsp; SolidWorks 2023 Maker Version does not allow multiple parts to share a single global variable file. This is more than inconvenient; SWECompare is a node.js tool that tries to resolve this by comparing exported equation files accordingly.<BR>
So why not use diff? Well?<BR>
<UL>
<LI> I needed the ability to ignore missing comments.</LI>
<LI> I needed the ability to audit for unused variables.</LI>
<LI> Exported files can contain different equations like "d1@Something" which needs to be ignored</LI>
</UL>

<BR><BR>
## How to use SWECompare to compare two equation files
&nbsp;&nbsp;&nbsp; Run SWECompare specifying both equation files.

<BR><BR>
For Example:
```
   SWECompare equationsFile1.txt equationsFile2.txt
```
<UL>
</LI>To ignore comments that may be different, specify -ic
</LI>By default file2 is also compared with file1. This can be turned off by specifying: -nr
</UL>

<BR><BR>
## How to use SWECompare to find unused variables
&nbsp;&nbsp;&nbsp; Run SWECompare specifying a single equations files.

<BR><BR>
For Example:
```
   SWECompare equationsFile.txt
```

<BR><BR>
## License
See [LICENSE](LICENSE)



<!---
Link References (Not Local)
-->

[ztalbot2000]:https://github.com/ztalbot2000
