# export JAVA_HOME=`/usr/libexec/java_home -v 11`export PATH="/usr/local/opt/python@3.7/bin:$PATH"
# export JAVA_HOME=$(/usr/libexec/java_home)


export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export NVM_DIR=~/.nvm 
source $(brew --prefix nvm)/nvm.sh 
export ANT_HOME=/opt/clearly/ant 
export EP_LIB=/opt/clearly/library
export VAULT_CLI=/opt/clearly/vault-cli
export JAVA_HOME=/Users/anand.rajendran/.jenv/versions/1.8
export PATH=$PATH:$ANT_HOME/bin:$VAULT_CLI/bin
export PATH=$PATH:/Users/anand.rajendran/Personal/Tech/Softwares/kafka_2.13-2.8.0/bin

    

# export PATH=$PATH:$ANT_HOME/bin:$VAULT_CLI/bin:$JAVA_HOME/bin


# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gau='git add -u'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gpl='git pull'
alias gph='git push'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias grd='git rebase develop'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias gstc='git stash clear'
alias gl='git log'
alias gbdl='git branch -D'
alias gmd='git merge develop'
alias grh='git reset --hard'
alias gcan='git commit --amend --no-edit'

# ----------------------
# Docker Aliases
# ----------------------
alias di='docker images'
alias dp='docker ps'
alias dpa='docker ps -a'
alias dpaq='docker ps -aq'
alias dsa='docker stop $(docker ps -aq)'
alias dra='docker rm $(docker ps -aq)'

# ************************************************
# Deletes the local branch
#
# Parameter(s)
#   $1 => branch to be deleted    
# ************************************************
deleteLocalBranch() {
    # validation: Should not be in the branch to be deleted.
    gstatus=$(git status)
    if [[ $gstatus =~ $1 ]]
        then
            echo "You are in the same branch as the one to be deleted. So, checking out master branch...."
            git checkout master
    fi

    localDelStatus=$(git branch -D $1)

    if [[ $localDelStatus =~ "Deleted branch $1" ]]
    then
        echo "Local branch '$1' deleted."
    else
        echo "Local branch could not be deleted."
    fi
    printf "\n"
}


# ************************************************
# Deletes the remote branch
#
# Parameter(s)
#   $1 => branch to be deleted    
# ************************************************
deleteRemoteBranch() {
    remoteDelStatus=$(git push -d origin $1) 
    #TODO the value is not set to remoteDelStatus. Once it fixed uncomment the below code
    # if [[ ($remoteDelStatus =~ "[deleted]") ]] 
    # then
    #     echo "Remote branch '$1' deleted."
    # else
    #     echo "Remote branch could not be deleted."
    # fi
    printf "\n"
     
}

# ************************************************
# Deletes the local and remote branch
#
# Parameter(s)
#   $1 => branch to be deleted    
# ************************************************
deleteBranch() {
    if [[ -z $1 ]]
    then
        echo "Branch name is empty! Please enter a valid branch name."

    else
        echo "Branch to be deleted: $1"
        echo ""

        echo "Deleting local branch..."
        deleteLocalBranch $1

        echo "Deleting remote branch..."
        deleteRemoteBranch $1
        echo "####################################"
        printf "\n\n\n"
    fi
       
}


# ************************************************
# Deletes the local and remote branch with the pattern specified
#
# Parameter(s)
#   $1 => pattern to match    
# ************************************************
deleteBranchesWithPattern(){
    if [[ -z $1 ]]
    then
        echo "pattern is empty! Please enter a pattern"
    else
        allRemotesBranches=$(git branch --remote | grep $1)
        stringToRemove="origin/"
        branchNames=${allRemotesBranches//$stringToRemove/}

        for branchName in $branchNames
        do
            deleteBranch  $branchName
        done
    fi

}


