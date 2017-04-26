set(THIS_VERSION 1.0.0)
if ("${defined.function.generate_library_interface}" VERSION_LESS "${THIS_VERSION}")
    set(defined.function.generate_library_interface "${THIS_VERSION}")

    function(generate_library_interface outvar)
        set(options SYSTEM)
        set(oneValueArgs BASE LIBRARY_NAME INSTALL_PATH)
        set(multiValueArgs FILES)
        cmake_parse_arguments(ARG "${options}"
                "${oneValueArgs}" "${multiValueArgs}"
                ${ARGN})
        set(open_include "\"")
        set(close_include "\"")
        if (ARG_SYSTEM)
            set(open_include "<")
            set(close_include ">")
        endif ()
        if (NOT ARG_BASE)
            message(FATAL_ERROR "generate_header - no BASE set")
        endif ()
        if (NOT ARG_LIBRARY_NAME)
            message(FATAL_ERROR "generate_header - no LIBRARY_NAME set")
        endif ()
        if (NOT ARG_FILES)
            message(FATAL_ERROR "generate_header - no FILES set")
        endif ()

        set(include_string "")
        set(sep "")
        foreach (file IN LISTS ARG_FILES)
            string(REGEX MATCH ".*\\.(hpp|h|h\\+\\+|hxx)$" is_hpp "${file}")
            if (is_hpp)
                string(REGEX REPLACE "^${ARG_BASE}/(.*)" "\\1" modified "${file}")
                string(CONCAT include_string "${include_string}" "${sep}" "#include ${open_include}${ARG_INSTALL_PATH}${modified}${close_include}")
                set(sep "\n")
            endif ()
        endforeach ()
        configure_file(${ARG_BASE}/${ARG_LIBRARY_NAME}.hpp.in ${ARG_BASE}/${ARG_LIBRARY_NAME}.hpp)

        set(${outvar} "${ARG_BASE}/${ARG_LIBRARY_NAME}.hpp" PARENT_SCOPE)
    endfunction()

endif ()