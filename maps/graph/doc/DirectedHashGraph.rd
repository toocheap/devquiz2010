=begin

=DirectedHashGraph �N���X

Hash ���g���Ď��������A���ʂ̗L���O���t�B

==�C���N���[�h���Ă��郂�W���[��:

* ((<Graph|URL:Graph.html>))

==�N���X���\�b�h:

--- DirectedHashGraph.new([vertices[, edges, [params]]])
    
    ���_ ((|vertices|)) �A�� ((|edges|)) �����L���O���t�����܂��B
    
    ((|vertices|)) �ɂ͒��_�̔z����w�肵�܂�(��: [0, 1, 2, 3])�B
    ���_�� Object#eql? �œ��l��r�ł���I�u�W�F�N�g�Ȃ�A���ł������ł��B
    
    ((|edges|)) �ɂ͕ӂ̔z����w�肵�܂�(��: [[0, 1, 1.0], [2, 3, 2.0]])�B
    �e�ӂ� [�n�_, �I�_, �d��] �Ƃ����z��Ŏw�肵�܂��B
    �d�݂͏ȗ��\�ł��B
    
    ���_�ƕӂ́A���Ƃ��� (({add_vertex})) �A (({add_edge})) �Ȃǂ�
    �ǉ��ł��܂��B
    
    ((|params|)) �� ((<Graph|URL:Graph.html>))#parameter �̖߂�l��ݒ肷��
    �p�����[�^�ł��B���܂�g���܂���B

==���\�b�h:

�O���t�N���X���ʂ̃��\�b�h�̐�����
((<Graph|URL:Graph.html>)) �A((<GraphAlgorithm|URL:GraphAlgorithm.html>))
�ɗL��܂��B�Q�Ƃ��Ă��������B

--- self[ v, w ] = weight
    
    �� (({[v, w]})) �̏d�݂� ((|weight|)) �ɂ��܂��B
    
    �� (({[v, w]})) ��������΁A���܂��B
    
--- add_edge(v, w[, weight])
    
    (({self[v, w]= weight})) �Ɠ����ł��B ((|weight|))
    ���ȗ������ (({1})) �ɂȂ�܂��B
    
--- delete_edge(v, w)
    
    �� (({[v, w]})) ���폜���܂��B
    
--- add_vertex(v)
    
    ���_ ((|v|)) ��ǉ����܂��B
    
--- delete_vertex(v)
    
    ���_ ((|v|)) ���폜���܂��B
    
    ((|v|)) ���n�_��I�_�Ƃ���ӂ��폜���܂��B
