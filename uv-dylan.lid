library:        uv-dylan
target-type:    dll
Files:          library
                loop-wrapper
                handle-wrapper
                error-wrapper
                timer-wrapper
C-source-files: timer-support.c
C-libraries:    uv.a
