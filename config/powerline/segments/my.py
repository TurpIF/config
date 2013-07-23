# -*- coding: utf8 -*-

from __future__ import absolute_import

import sh

def git_status_line(pl, head = "", detached = "#", dirty = " +"):
    '''Return the current status of a git branch.

    :param str head:
        text to prepend if the branch is the head
    :param str detached:
        text to prepend if the branch is in a detached head state
    :param str dirty:
        text to append if the branch is dirty

    Highlight groups used: ``branch_clean``, ``branch_dirty``, ``branch``.
    '''

    # return None

    branch = '(no branch)'
    scol = ['branch']

    try:
        sh.git('symbolic-ref', 'HEAD')
        # Get the used branch
        for b in sh.git.branch().split('\n'):
            if b and  b[0] == '*':
                branch = head + ' '.join(b.split(' ')[1:])
                break
    except sh.ErrorReturnCode_128:
        # Detached from HEAD
        try:
            branch = detached + sh.git('show-ref', '--head', '--abbrev', '-s').split('\n')[0]
        except sh.ErrorReturnCode_128:
            # Not a git repo
            return None

    try:
        sh.git.diff('--quiet')
        scol = ['branch_clean'] + scol
    except sh.ErrorReturnCode_1:
        # Dirty branch
        scol = ['branch_dirty'] + scol
        branch = branch + dirty

    return [{
        'contents': branch,
        'highlight_group': scol,
        }]
