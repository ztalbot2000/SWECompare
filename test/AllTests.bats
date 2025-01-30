setup()
{
   load './setup'
   _common_setup
}

@test "Test Equations in two files are equal," {
run node ../SWECompare testData/equations.txt testData/equations.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[4]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test Equations in two files. Second is missing a global," {
run node ../SWECompare testData/equations.txt testData/equationsMissingGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingGlobal.txt"
   assert_equal "${lines[4]}" "Around line number: 61 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"DistanceFromBedSideToStepperHole\" not found in testData/equationsMissingGlobal.txt"
   assert_equal "${lines[6]}" "expected value:  ( \"FrontBackRailLength\" - \"BedWidth\" - \"StepperMountingHoleOffsetFromLeftOrRightSide\" * 2 - \"StepperHoleDiameter\" ) / 2"
   assert_equal "${lines[7]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 8
}

@test "Test Equations in two files, Second has Missing comment but -nc specified" {
run node ../SWECompare -nc testData/equations.txt testData/equationsMissingComment.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingComment.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingComment.txt"
   assert_equal "${lines[4]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test Equations in two files, Second has Missing comment and -nc not specified" {
run node ../SWECompare testData/equations.txt testData/equationsMissingComment.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingComment.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingComment.txt"
   assert_equal "${lines[4]}" "Around line number: 1 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"RailThickness\" matches but not the comment at line number 1 of testData/equationsMissingComment.txt"
   assert_equal "${lines[6]}" "< "
   assert_equal "${lines[7]}" "  ^"
   assert_equal "${lines[8]}" "> 'This comment is in second file"
   assert_equal "${lines[9]}" "  ^"
   assert_equal "${lines[10]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 11
}

@test "Test Equations in two files, Second has different Global vaiable value" {
run node ../SWECompare testData/equations.txt testData/equationsWithDifferentGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[4]}" "Around line number: 51 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"StandardWallThickness\" matches but not the value at line number 51 of testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[6]}" "<  3mm"
   assert_equal "${lines[7]}" "   ^"
   assert_equal "${lines[8]}" ">  5mm"
   assert_equal "${lines[9]}" "   ^"
   assert_equal "${lines[10]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 11
}

@test "Test Equations in two files with -r, Second has different Global vaiable value" {
run node ../SWECompare -d -r testData/equations.txt testData/equationsWithDifferentGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[4]}" "Around line number: 51 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"StandardWallThickness\" matches but not the value at line number 51 of testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[6]}" "<  3mm"
   assert_equal "${lines[7]}" "   ^"
   assert_equal "${lines[8]}" ">  5mm"
   assert_equal "${lines[9]}" "   ^"
   assert_equal "${lines[10]}" "Around line number: 51 of testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[11]}" "variable: \"StandardWallThickness\" matches but not the value at line number 51 of testData/equations.txt"
   assert_equal "${lines[12]}" "<  5mm"
   assert_equal "${lines[13]}" "   ^"
   assert_equal "${lines[14]}" ">  3mm"
   assert_equal "${lines[15]}" "   ^"
   assert_equal "${lines[16]}" "Differences detected: 2"
   # No more lines than expected
   assert_equal "${#lines[@]}" 17
}

@test "Test Equations in two files, Second has missing \"D1@Something\" but -ie not specified" {
run node ../SWECompare testData/equations.txt testData/equationsMissingEquation.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[4]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test Equations in two files, Second has missing \"D1@Something\" but -ie specified" {
run node ../SWECompare -ie testData/equations.txt testData/equationsMissingEquation.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[4]}" "Around line number: 62 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"D7@CornerrSketch1\" not found in testData/equationsMissingEquation.txt"
   assert_equal "${lines[6]}" "expected value: \"BedLShortSide\""
   assert_equal "${lines[7]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 8
}

@test "Test Equations in three files, Third finds variable " {
run node ../SWECompare testData/equations.txt testData/equationsMissingEquation.txt testData/equationsFoundGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[2]}" "Adding file: testData/equationsFoundGlobal.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[4]}" "Reading file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[5]}" "Reading file: testData/equationsFoundGlobal.txt"
   assert_equal "${lines[6]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 7
}

@test "Test Equations in four files, Fourth finds incorrect variable " {
run node ../SWECompare testData/equations.txt testData/equationsMissingEquation.txt testData/equationsFoundGlobal.txt testData/equationsFoundIncorrectGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[2]}" "Adding file: testData/equationsFoundGlobal.txt"
   assert_equal "${lines[3]}" "Adding file: testData/equationsFoundIncorrectGlobal.txt"
   assert_equal "${lines[4]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[5]}" "Reading file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[6]}" "Reading file: testData/equationsFoundGlobal.txt"
   assert_equal "${lines[7]}" "Reading file: testData/equationsFoundIncorrectGlobal.txt"
   assert_equal "${lines[8]}" "Around line number: 61 of testData/equations.txt"
   assert_equal "${lines[9]}" "variable: \"DistanceFromBedSideToStepperHole\" matches but not the value at line number 1 of testData/equationsFoundIncorrectGlobal.txt"
   assert_equal "${lines[10]}" "<  ( \"FrontBackRailLength\" - \"BedWidth\" - \"StepperMountingHoleOffsetFromLeftOrRightSide\" * 2 - \"StepperHoleDiameter\" ) / 2"
   assert_equal "${lines[11]}" "                                                                                            ^"
   assert_equal "${lines[12]}" ">  ( \"FrontBackRailLength\" - \"BedWidth\" - \"StepperMountingHoleOffsetFromLeftOrRightSide\" * 222 - \"StepperHoleDiameter\" ) / 2"
   assert_equal "${lines[13]}" "                                                                                            ^"
   assert_equal "${lines[14]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 15
}

@test "Test for Unused Globals in a file" {
run node ../SWECompare -v testData/missingGlobal2.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/missingGlobal2.txt"
   assert_equal "${lines[1]}" "Reading file: testData/missingGlobal2.txt"
   assert_equal "${lines[2]}" "Around line number: 1 of testData/missingGlobal2.txt"
   assert_equal "${lines[3]}" "variable: \"RailThickness\" was unused"
   assert_equal "${lines[4]}" "Unused globals found: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test for Unused Globals in a file spelled incorrectly" {
run node ../SWECompare -v testData/missingGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/missingGlobal.txt"
   assert_equal "${lines[1]}" "Reading file: testData/missingGlobal.txt"
   assert_equal "${lines[2]}" "Around line number: 1 of testData/missingGlobal.txt"
   assert_equal "${lines[3]}" "variable: \"RailThickness\" was unused"
   assert_equal "${lines[4]}" "Unused globals found: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test for a Missing Global in a file but found in another" {
run node ../SWECompare -v testData/missingGlobal.txt testData/foundGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/missingGlobal.txt"
   assert_equal "${lines[1]}" "Adding file: testData/foundGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/missingGlobal.txt"
   assert_equal "${lines[3]}" "Reading file: testData/foundGlobal.txt"
   assert_equal "${lines[4]}" "No unused globals found"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test for a Missing Global containing file comments without debug " {
run node ../SWECompare -v testData/commentAtFirstLineFromWindows.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/commentAtFirstLineFromWindows.txt"
   assert_equal "${lines[1]}" "Reading file: testData/commentAtFirstLineFromWindows.txt"
   assert_equal "${lines[2]}" "No unused globals found"
   # No more lines than expected
   assert_equal "${#lines[@]}" 3
}

@test "Test for a Missig Global containing file comments with debug " {
run node ../SWECompare -v -debug testData/commentAtFirstLineFromWindows.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/commentAtFirstLineFromWindows.txt"
   assert_equal "${lines[1]}" "Reading file: testData/commentAtFirstLineFromWindows.txt"
   assert_equal "${lines[2]}" "shifting nodes[0] a file comment line"
   assert_equal "${lines[3]}" "pushing nodes[0] a file comment line"
   assert_equal "${lines[4]}" "pushing nodes[0] VARIABLE: \"V1 BottomOfLowerRail\", VALUE:  \"LegHeight\", COMMENT: "
   assert_equal "${lines[5]}" "pushing nodes[0] a file comment line"
   assert_equal "${lines[6]}" "pushing nodes[0] VARIABLE: \"RailThickness\", VALUE:  .125in, COMMENT: 'Spec"
   assert_equal "${lines[7]}" "pushing nodes[0] VARIABLE: \"D1@LeftSideHoles-Sketch3\", VALUE: \"V1 BottomOfLowerRail\", COMMENT: "
   assert_equal "${lines[8]}" "pushing nodes[0] VARIABLE: \"D2@Rails\", VALUE: \"RailThickness\", COMMENT: "
   assert_equal "${lines[9]}" "Comparing file variables"
   assert_equal "${lines[10]}" "searchForUnusedGlobal: Ignoring FILECOMMENT"
   assert_equal "${lines[11]}" "searchForUnusedGlobal: Ignoring FILECOMMENT in testData/commentAtFirstLineFromWindows.txt line: 0 COMMENT: # From VerticalSupportYardStickEquations.txt"
   assert_equal "${lines[12]}" "searchForUnusedGlobal: Ignoring FILECOMMENT in testData/commentAtFirstLineFromWindows.txt line: 2 COMMENT: # From BackLeftVerticalSupportEquations.txt"
   assert_equal "${lines[13]}" "searchForUnusedGlobal: Ignoring FILECOMMENT"
   assert_equal "${lines[14]}" "searchForUnusedGlobal: Ignoring FILECOMMENT in testData/commentAtFirstLineFromWindows.txt line: 0 COMMENT: # From VerticalSupportYardStickEquations.txt"
   assert_equal "${lines[15]}" "searchForUnusedGlobal: Ignoring FILECOMMENT in testData/commentAtFirstLineFromWindows.txt line: 2 COMMENT: # From BackLeftVerticalSupportEquations.txt"
   assert_equal "${lines[16]}" "No unused globals found"
   # No more lines than expected
   assert_equal "${#lines[@]}" 17
}


@test "Test for Unused globals with linked values" {
run node ../SWECompare -v -lv testData/linkedValues.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/linkedValues.txt"
   assert_equal "${lines[1]}" "Reading file: testData/linkedValues.txt"
   assert_equal "${lines[2]}" "No unused globals found"
   # No more lines than expected
   assert_equal "${#lines[@]}" 3
}

@test "Test a file with missing linked values" {
run node ../SWECompare -lv testData/linkedValuesWithMissingDefinitions.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/linkedValuesWithMissingDefinitions.txt"
   assert_equal "${lines[1]}" "Reading file: testData/linkedValuesWithMissingDefinitions.txt"
   assert_equal "${lines[2]}" "Around line number: 2 of testData/linkedValuesWithMissingDefinitions.txt"
   assert_equal "${lines[3]}" "Linked variable:  \"LegHeight\" was undefined"
   assert_equal "${lines[4]}" "Unused globals found: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test a file with no duplicate variables equations or comments" {
run node ../SWECompare -dup testData/equations.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[2]}" "0 duplicate(s) detected."
   # No more lines than expected
   assert_equal "${#lines[@]}" 3
}

@test "Test a file with duplicate variables" {
run node ../SWECompare -dup testData/duplicateEquations.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/duplicateEquations.txt"
   assert_equal "${lines[1]}" "Reading file: testData/duplicateEquations.txt"
   assert_equal "${lines[2]}" "\"RailThickness\" from line 1 duplicated on line 2"
   assert_equal "${lines[3]}" "\"RailThickness\" from line 1 duplicated on line 3"
   assert_equal "${lines[4]}" "2 duplicate(s) detected."
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test a file with duplicate variables and incorrect equations/comments" {
run node ../SWECompare -dup -ie testData/duplicateEquationsWithAnIncorrectVariable.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/duplicateEquationsWithAnIncorrectVariable.txt"
   assert_equal "${lines[1]}" "Reading file: testData/duplicateEquationsWithAnIncorrectVariable.txt"
   assert_equal "${lines[2]}" "\"RailThickness\" from line 1 duplicated on line 2"
   assert_equal "${lines[3]}" "\"RailThickness\" Equation on line 1 differs from line 2."
   assert_equal "${lines[4]}" "\" 3.175mm\" != \" 2.175mm\""
   assert_equal "${lines[5]}" "\"RailThickness\" from line 1 duplicated on line 3"
   assert_equal "${lines[6]}" "\"RailThickness\" Comment on line 1 differs from line 3."
   assert_equal "${lines[7]}" "\"'One eight inch\" != \"'One eight nch\""
   assert_equal "${lines[8]}" "2 duplicate(s) detected."
   # No more lines than expected
   assert_equal "${#lines[@]}" 9
}


@test "Test if variable in first file not found in second" {
run node ../SWECompare testData/equations.txt -ie testData/equationsMissingEquation.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[4]}" "Around line number: 62 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"D7@CornerrSketch1\" not found in testData/equationsMissingEquation.txt"
   assert_equal "${lines[6]}" "expected value: \"BedLShortSide\""
   assert_equal "${lines[7]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 8
}
