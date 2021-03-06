// RUN: not %target-swiftc_driver %s 2>&1 | FileCheck -check-prefix=DEFAULT %s
// RUN: not %target-swiftc_driver -warnings-as-errors %s 2>&1 | FileCheck -check-prefix=WERR %s
// RUN: not %target-swiftc_driver -suppress-warnings %s 2>&1 | FileCheck -check-prefix=NOWARN %s

// RUN: not %target-swiftc_driver -suppress-warnings -warnings-as-errors %s 2>&1 | FileCheck -check-prefix=FLAGS_CONFLICT %s
// FLAGS_CONFLICT: error: conflicting options '-warnings-as-errors' and '-suppress-warnings'

func foo() -> Int {
	let x = 1
	var y = 2 
// DEFAULT:    warning: variable 'y' was never mutated; consider changing to 'let' constant 	
// WERR:       error: variable 'y' was never mutated; consider changing to 'let' constant 	
// NOWARN-NOT: variable 'y' was never mutated
	return x + y
}

func bar() {
	foo()
// To help anchor the checks, have an error. Put it inside a later function, to help make sure it comes after
	xyz
// DEFAULT: error: use of unresolved identifier 'xyz'
// WERR:    error: use of unresolved identifier 'xyz'
// NOWARN:  error: use of unresolved identifier 'xyz'
}
