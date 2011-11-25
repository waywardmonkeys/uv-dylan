library:        uv-dylan
target-type:    executable
Files:          library
                loop-wrapper
                handle-wrapper
                error-wrapper
                check-wrapper
                idle-wrapper
                prepare-wrapper
                timer-wrapper
                main
C-source-files: check-support.c
                idle-support.c
                prepare-support.c
                timer-support.c
C-libraries:    uv.a
