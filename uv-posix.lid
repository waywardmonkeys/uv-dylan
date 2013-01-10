library:        uv
target-type:    dll
executable:     uv-dylan
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
C-source-files: check-support.c
                handle-support.c
                idle-support.c
                loop-support.c
                prepare-support.c
                tcp-support.c
                timer-support.c
C-object-files: libuv/libuv.a
