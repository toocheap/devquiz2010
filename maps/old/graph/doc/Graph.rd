=begin

=Graph ���W���[��

�O���t�̊�{�I�ȑ�����`�������W���[���B

�Ǝ��̃O���t�N���X�����ꍇ�́A���́u�K�v�ȃ��\�b�h�v���`������ŁA
���̃��W���[�����C���N���[�h���܂��B

==�C���N���[�h���Ă��郂�W���[��:

* ((<GraphAlgorithm|URL:GraphAlgorithm.html>))

==�K�v�ȃ��\�b�h:

--- self[ v, w ]
    
    ���_ ((|v|)) �ƒ��_ ((|w|)) �����ԕӂ̏d�݁B
    
    �ӂ̏d�݂́A�A���S���Y���ɂ���ĕӂ̒�����ӂ̗e�ʂƂ��Ďg����l�ł��B
    
    ((|v|)) �� ((|w|)) ���אڂłȂ��ꍇ�́A (({parameter(:default)}))
    �̒l(�f�t�H���g�ł� (({nil})) )��Ԃ��܂��B
    
--- each_vertex{ |v| ... }
    
    �O���t�̊e���_�ɑ΂��ČJ��Ԃ��܂��B
    
--- directed?()
    
    �L���O���t�Ȃ� (({true})) �A�����O���t�Ȃ� (({false})) ��Ԃ��܂��B
    
    �����O���t�Ƃ́A�S�Ă̒��_�ɂ��� (({self[v, w]==self[w, v]}))
    �ƂȂ�O���t�ł��B
    
== ���\�b�h:

--- adjacent?(v, w)
    
    ���_ ((|v|)) �ƒ��_ ((|w|)) ���א�(�܂�� (({[v, w]})) �����݂���)�Ȃ�
    (({true})) ��Ԃ��܂��B
    
    �אڂ��ǂ����́A (({self[v, w]!=parameter(:default)})) �Ŕ��肵�܂��B
    
    �L���O���t�ł́A (({adjacent?(v, w)})) �� (({adjacent?(w, v)})) ��
    ��v����Ƃ͌���܂���B
    
--- each_successing_vertex(v){ |w| ... }
    
    ((|v|)) ���n�_�Ƃ���S�Ă̕ӂ̏I�_�ɑ΂��ČJ��Ԃ��܂��B
    
--- each_edge(uniq= false){ |v, w| ... }
    
    �O���t�̊e�ӂɑ΂��ČJ��Ԃ��܂��B
    
    �����O���t�ł��A (({v, w})) �� (({w, v})) �ɑ΂��Čʂ�
    �J��Ԃ���܂��B�����h���ɂ́A ((|uniq|)) �� (({true})) ��
    �w�肵�܂��B
    
    �L���O���t�ł� ((|uniq|)) ���w�肵�Ă���������܂��B
    
--- out_degree(v)
    
    ���_ ((|v|)) �̏o����( ((|v|)) ���n�_�Ƃ���ӂ̐�)��Ԃ��܂��B
    
--- vertices
    
    �O���t�̑S�Ă̒��_��z��Ƃ��ĕԂ��܂��B
    
--- edges(uniq= false)
    
    �O���t�̑S�Ă̕ӂ�z��Ƃ��ĕԂ��܂��B
    
    ((|uniq|)) �̓����� (({each_edge})) �Ɠ����ł��B
    
--- parameter(name)
    
    �O���t�ɂ��Ẵp�����[�^�B ((<GraphAlgorithm|URL:GraphAlgorithm.html>))
    �̃��\�b�h�Ŏw�肷��p�����[�^�̃f�t�H���g�l�Ƃ��Ďg���܂��B
    
    �܂��A (({parameter(:default)})) �́A (({v})) �� (({w})) ���אڂłȂ��ꍇ��
    (({self[v, w]})) �̖߂�l�ɂȂ�܂��B
    
    �f�t�H���g�ł͏�� (({nil})) ��Ԃ��悤�ɂȂ��Ă��܂��B
    �K�v�ɉ����čĒ�`���Ă��������B
    
=end
