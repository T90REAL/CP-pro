# !/bin/bash
# created by xiao 
# usage : please use pro help to see the details
# this is just a simple bash script that automatically generates the cpp file with templates for algo
# note that you should change all the path to your own path
# todo: make it as a command line tool in the future

# {{{ gen
function generate_cp_file {
    # check if the file has already existed
    if [[ -f $1 ]]
    then
        echo "failed, ${1} already exists!"
        exit 0
    fi

    # creating the folders
    if [[ $3 != '' ]]
    then
        folders="${@:3}"
        # echo "folders : $folders"
        for char in $folders
        do
            if [[ "$char" =~ [[:space:]] ]]; then
                continue
            fi
            mkdir "$char" 2>/dev/null

            if [ $? -eq 0 ]; then
                echo "directory '$char' has been created."
            else
                echo "directory '$char' already exists or couldn't be created."
                exit 1
            fi

            cd $char 

            # creating the file
            if [[ $2 == "cpp" || $2 == "py" || $2 == "java" ]]
            then
                echo "successfully create ${1} with templates!"
                touch $1
                if [[ $2 == "cpp" ]]
                then
                    # get the template for competing
                    cat /users/liam/programming/algo/script/cpp2.cpp > $1
                fi

                if [[ $2 == "java" ]]
                then
                    # get the template for competing
                    cat /users/liam/programming/algo/script/javatem.java > $1
                fi

                # download the problem test case
                python3 /users/liam/programming/algo/script/fetch.py
            else
                echo "not support language!"
                cd ..
                rm -r $char
            fi

            cd ..

        done
    else
        # check if the file has already existed
        if [[ -f $1 ]]
        then
            echo "failed, ${1} already exists!"
            exit 1
        fi

        # creating the file
        if [[ $2 == "cpp" || $2 == "py" ]]
        then
            echo "successfully create ${1} with templates!"
            touch $1
            cat /users/liam/programming/algo/script/cpp.cpp > $1
            # cp /users/liam/programming/algo/script/test.py ./
        else
            echo "not support language!"
        fi
    fi
} 
# }}}

# {{{ create
function create_file {
    # check if the file has already existed
    if [[ -f $1 ]]
    then
        echo "failed, ${1} already exists!"
        exit 1
    fi

    # creating the folders
    directoties=""
    if [[ $3 != '' ]]
    then
        folders="${@:3}"
        # echo "folders : $folders"
        for char in $folders
        do
            if [[ "$char" =~ [[:space:]] ]]; then
                continue
            fi
            mkdir "$char" 2>/dev/null

            if [ $? -eq 0 ]; then
                echo "directory '$char' has been created."
                # directoties="$directoties$char"
            else
                echo "directory '$char' already exists or couldn't be created."
                continue
            fi

            cd $char 

            # creating the file
            if [[ $2 == "cpp" || $2 == "py" ]]
            then
                echo "successfully create ${1} with templates!"
                touch $1
                if [[ $2 == "cpp" ]]
                then
                    cat /users/liam/programming/algo/script/cpp2.cpp > $1
                fi

            else
                echo "not support language!"
                cd ..
                rm -r $char
            fi

            cd ..

        done
        # echo "created folders: "
        # for ((i = 0; i < ${#directoties}; i++)); do
        #     char="${directoties:i:1}"
        #     printf "$char "
        # done
    else
        # check if the file has already existed
        if [[ -f $1 ]]
        then
            echo "failed, ${1} already exists!"
            exit 0
        fi

        # creating the file
        if [[ $2 == "cpp" || $2 == "py" || $2 == "java" ]]
        then
            echo "successfully create ${1} with templates!"
            touch $1

            if [[ $2 == "cpp" ]]
            then
                cat /users/liam/programming/algo/script/cpp2.cpp > $1
            fi

            if [[ $2 == "java" ]]
            then
                # get the template for competing
                cat /users/liam/programming/algo/script/javatem.java > $1
            fi

        else
            echo "not support language!"
        fi
    fi
}

function delete_file {
    if [[ -f $2 ]] 
    then
        echo "removing ${2} and other cp-related files..."
        rm -r $file_name.dsym
        rm $2
        rm $file_name.in
        rm $file_name.out
        python3 /users/liam/programming/algo/script/dl.py
        rm test.py
    else 
        echo "oh my dear! there's no $2 file!"
    fi
}
# }}}

function fetch_info {
    echo "start downloading the problems..."
    python3 /users/liam/programming/algo/script/fetch.py
}

function get_dependency {
    echo "get all the dependencies python files"
    cp /users/liam/programming/algo/script/dl.py ./
    cp /users/liam/programming/algo/script/fetch.py ./
    cp /users/liam/programming/algo/script/test.py ./
}

function display_help {
    echo "usage: pro <options> <filename> [folders]"
    echo ""
    echo "pro gen <filename> [folders]          generate the cpp/python file with [alias g]"
    echo "pro help                              show the usage [alias h]"
    echo "pro fetch                             fetch the test case information on the online judge [alias f]"
    echo "pro create <filename> [folders]       simply create the cpp/python file with your own template [alias c]"
    echo "pro delete                            delete all the cp-related files [alias d]"
}

function delete_file {
    cp /users/liam/programming/algo/script/dl.py ./
    rm sol
    rm -r sol.dsym
    python3 dl.py
    rm dl.py
    rm test.py
    rm fetch.py
}

# main 

fileoptions="$1"
filename="$2"
# extract the file type (extension)
file_type="${filename##*.}"
# extract the file name (without extension)
file_name="${filename%.*}"

folders="${@:3}"


if [[ $# -eq 0 ]]
then
    display_help
    exit 1
fi

case "$fileoptions" in
    gen | g)
        generate_cp_file $filename $file_type $folders
        ;;
    create | c)
        create_file $filename $file_type $folders
        ;;
    help | h)
        display_help
        ;;
    fetch | f)
        fetch_info
        ;;
    delete | d)
        delete_file
        ;;
    get)
        get_dependency
        ;;
    *)
        echo ""
        echo "unkonw options: '$fileoptions' "
        display_help
        exit 1
        ;;
esac

exit 0




