# -*- coding: utf8 -*-

from __future__ import absolute_import

import sh

from powerline.segments.vim import file_directory
from powerline.theme import requires_segment_info

@requires_segment_info
def git_status_line(pl, segment_info, head = "", detached = "#", dirty = " +"):
    '''Return the current status of a git branch.

    :param str head:
        text to prepend if the branch is the head
    :param str detached:
        text to prepend if the branch is in a detached head state
    :param str dirty:
        text to append if the branch is dirty

    Highlight groups used: ``branch_clean``, ``branch_dirty``, ``branch``.
    '''
    try:
        path = None
        try:
            path = file_directory(pl, segment_info, False, False, False)
        except KeyError:
            pass

        if path is None:
            path = segment_info['getcwd']()
        sh.cd(path)
        branch = '(no branch)'
        scol = ['branch']

        try:
            sh.git('symbolic-ref', 'HEAD')
            for b in sh.git.branch().split('\n'):
                if b and  b[0] == '*':
                    branch = head + ' '.join(b.split(' ')[1:])
                    break
        except sh.ErrorReturnCode_128:
            branch = detached + sh.git('show-ref', '--head', '--abbrev', '-s').split('\n')[0]

        try:
            sh.git.diff('--quiet')
            scol = ['branch_clean'] + scol
        except sh.ErrorReturnCode_1:
            scol = ['branch_dirty'] + scol
            branch = branch + dirty

        return [{
            'contents': branch,
            'highlight_group': scol,
            }]
    except sh.ErrorReturnCode_128:
        return None
