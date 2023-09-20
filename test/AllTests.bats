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
   assert_equal "${lines[4]}" "Line number: 61 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"DistanceFromBedSideToStepperHole\" not found in testData/equationsMissingGlobal.txt"
   assert_equal "${lines[6]}" "expected value:  ( \"FrontBackRailLength\" - \"BedWidth\" - \"StepperMountingHoleOffsetFromLeftOrRightSide\" * 2 - \"StepperHoleDiameter\" ) / 2"
   assert_equal "${lines[7]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 8
}

@test "Test Equations in two files, Second has Missing comment but -ic not specified" {
run node ../SWECompare testData/equations.txt testData/equationsMissingComment.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingComment.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingComment.txt"
   assert_equal "${lines[4]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test Equations in two files, Second has Missing comment and -ic specified" {
run node ../SWECompare -ic testData/equations.txt testData/equationsMissingComment.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingComment.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingComment.txt"
   assert_equal "${lines[4]}" "Line number: 1 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"RailThickness\" matches but not the comment at line number 1 of testData/equationsMissingComment.txt"
   assert_equal "${lines[6]}" "'This comment not in original file != "
   assert_equal "${lines[7]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 8
}

@test "Test Equations in two files, Second has different Global vaiable value" {
run node ../SWECompare testData/equations.txt testData/equationsWithDifferentGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[4]}" "Line number: 51 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"StandardWallThickness\" matches but not the value at line number 51 of testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[6]}" " 5mm !=  3mm"
   assert_equal "${lines[7]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 8
}

@test "Test Equations in two files with -r, Second has different Global vaiable value" {
run node ../SWECompare -r testData/equations.txt testData/equationsWithDifferentGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[4]}" "Line number: 51 of testData/equations.txt"
   assert_equal "${lines[5]}" "variable: \"StandardWallThickness\" matches but not the value at line number 51 of testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[6]}" " 5mm !=  3mm"
   assert_equal "${lines[7]}" "Line number: 51 of testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[8]}" "variable: \"StandardWallThickness\" matches but not the value at line number 51 of testData/equations.txt"
   assert_equal "${lines[9]}" " 3mm !=  5mm"
   assert_equal "${lines[10]}" "Differences detected: 2"
   # No more lines than expected
   assert_equal "${#lines[@]}" 11
}

@test "Test Equations in two files, Second has missing \"D1@Something\"" {
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
   assert_equal "${lines[8]}" "Line number: 61 of testData/equations.txt"
   assert_equal "${lines[9]}" "variable: \"DistanceFromBedSideToStepperHole\" matches but not the value at line number 1 of testData/equationsFoundIncorrectGlobal.txt"
   assert_equal "${lines[10]}" " ( \"FrontBackRailLength\" - \"BedWidth\" - \"StepperMountingHoleOffsetFromLeftOrRightSide\" * 222 - \"StepperHoleDiameter\" ) / 2 !=  ( \"FrontBackRailLength\" - \"BedWidth\" - \"StepperMountingHoleOffsetFromLeftOrRightSide\" * 2 - \"StepperHoleDiameter\" ) / 2"
   assert_equal "${lines[11]}" "Differences detected: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 12
}

@test "Test a Missing Global in a file" {
run node ../SWECompare testData/missingGlobal2.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/missingGlobal2.txt"
   assert_equal "${lines[1]}" "Reading file: testData/missingGlobal2.txt"
   assert_equal "${lines[2]}" "Line number: 1 of testData/missingGlobal2.txt"
   assert_equal "${lines[3]}" "variable: \"RailThickness\" was unused"
   assert_equal "${lines[4]}" "Unused globals found: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test a Missing Global in a file Global in \"d1@Something\" spelled incorrectly" {
run node ../SWECompare testData/missingGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/missingGlobal.txt"
   assert_equal "${lines[1]}" "Reading file: testData/missingGlobal.txt"
   assert_equal "${lines[2]}" "Line number: 1 of testData/missingGlobal.txt"
   assert_equal "${lines[3]}" "variable: \"RailThickness\" was unused"
   assert_equal "${lines[4]}" "Unused globals found: 1"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test a Missing Global in a file but found in another" {
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

