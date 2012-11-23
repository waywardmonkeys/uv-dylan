library:        uv-dylan
target-type:    executable
Files:          library
                loop-wrapper
                handle-wrapper
                error-wrapper
                check-wrapper
                idle-wrapper
                prepare-wrapper
                stream-wrapper
                tcp-wrapper
                timer-wrapper
                main
C-source-files: check-support.c
                handle-support.c
                idle-support.c
                loop-support.c
                prepare-support.c
                tcp-support.c
                timer-support.c
C-header-files: libuv/libuv.a
C-libraries:    libuv.a
