# Go resources/tips/tricks
### online playground
```
https://go.dev/play/
```
### learning resources
```
Language spec                   https://go.dev/ref/spec
A tour of Go                    https://go.dev/tour
How to write Go code            https://go.dev/doc/code
Effective Go                    https://go.dev/doc/effective_go
Writing an Interpreter in Go    https://interpreterbook.com/
Let's Go                        https://lets-go.alexedwards.net/
    Build profressional web apps with Go
Let's Go Further                https://lets-go-further.alexedwards.net/
    Building APIs and web apps in Go
Learn Go with Tests             https://quii.gitbook.io/learn-go-with-tests
```

### slices
## you can reslice a slice and grow it to capacity
s = []int{1,2,3,4,5,6}
s = s[:1]  // reduces length, not capacity
s = s[:cap(s)] // back to original length 
## but you can never grow the beginning of a slice lower
s = s[-5:]  ILLEGAL

### generic functions
func sliceinfo [T any] (s []T) {
	fmt.Printf("slice data: %v\n", s)
	fmt.Printf("len: %v, cap: %v, &s[0]: %v,k &s[len-1]: %v\n", len(s), cap(s), &s[0], &s[len(s)-1])
}

Note that you cannot pass in a []int to a function taking []any, they are stored differently, and what if you wrote this:

func main() {
     foo(make([]int, 5))
}

func foo(s []any) {
    s[0] = "howdy" // oops! 
}

### goroutines / concurrency

for unbuffered channels, both <-ch and ch<- block until the other is also ready, then they body complete

select statements with no channels ready and no default: statement block until one of the cases is ready

### mixing assembly and go
follow typical examples, but you MUST build with a module!  go run file.go or go build file.go will NOT work!
go mod init my-module-name
go build

put the assembly in somefile.s
```asm
#include "textflag.h"

TEXT ·add(SB), NOSPLIT, $0-24
    MOVQ x+0(FP), BX    
    MOVQ y+8(FP), BP    
    ADDQ BP, BX        
    MOVQ BX, ret+16(FP)
    RET                 
```

and then main.go is:
```go
package main

import "fmt"

// note: to declare the asm function prototype, do it in go but with no { body } 
func add(x, y int64) int64

func main() {
    fmt.Println("Add:       ", add(10, 5))
}
```
