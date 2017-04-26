set(THIS_VERSION 1.0.0)
if (defined.function.prefix_files VERSION_LESS "${THIS_VERSION}")

    set(defined.function.prefix_files "${THIS_VERSION}")

    function(prefix_files outvar)
        set(options)
        set(oneValueArgs PREFIX APPEND)
        set(multiValueArgs FILES)
        cmake_parse_arguments(ARG "${options}"
                "${oneValueArgs}" "${multiValueArgs}"
                ${ARGN})
        if (NOT ARG_PREFIX)
            message(FATAL_ERROR "prefix_files - no PREFIX set")
        endif ()
        if (NOT ARG_FILES)
            message(FATAL_ERROR "prefix_files - no FILES set")
        endif ()

        set(result)
        foreach (file ${ARG_FILES})
            set(prefixed_file "${ARG_PREFIX}/${file}")
            list(APPEND result "${prefixed_file}")
        endforeach ()
        set("${outvar}" "${result}" PARENT_SCOPE)
        if (ARG_APPEND)
            set(append_list "${${ARG_APPEND}}")
            list(APPEND append_list ${result})
            set("${ARG_APPEND}" "${append_list}" PARENT_SCOPE)
        endif ()
    endfunction()

endif ()
