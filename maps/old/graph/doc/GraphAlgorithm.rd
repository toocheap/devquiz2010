=begin

=GraphAlgorithm ���W���[��

�O���t�̃A���S���Y���W�B

((<Graph|URL:Graph.html>)) �ɃC���N���[�h����Ă���̂ŁA
�ȉ��̃��\�b�h�̓O���t�N���X(
((<UndirectedHashGraph|URL:UndirectedHashGraph.html>))�Ȃ�)��
���\�b�h�Ƃ��ČĂяo���܂��B

�����Ȃ�ȉ��̐�����ǂނ��A ((<simple_example.rb|URL:simple_example.rb>))
����������������₷���Ǝv���܂��B

== ���\�b�h:

--- depth_first_search(params)
    
    �O���t�ɑ΂��āA�[���D��T�����s���܂��B
    
    �p�����[�^�͑S�āA�n�b�V�� ((|params|)) �Ɏw�肵�܂��B
    �L���ȃp�����[�^���ȉ��Ɏ����܂��B
    
    :(({params[:root]}))
      �K�{�B�T�����n�߂钸�_���w�肵�܂��B
    :(({params[:target]}))
      �ȗ��B���̒��_�ɂ��ǂ蒅������A�T�����I�����܂��B
    :(({params[:predecessor]}))
      �ȗ��B Hash ���w�肷��ƁA���� Hash ��
      �u���ꂼ��̒��_�ɓ��B���钼�O�ɂǂ̒��_��ʂ������v���L�^����܂��B
    :(({params[:vertex_number]}))
      �ȗ��B Hash ���w�肷��ƁA���� Hash ��
      �u���ꂼ��̒��_�ɉ��Ԗڂɓ��B�������v���L�^����܂��B
    :(({params[:on_discover_vertex]}))
      �ȗ��BProc �� Method ���w�肷��ƁA���_ (({v})) �ɓ��B�������ɁA
      (({params[:on_discover_vertex].call(v)})) �����s����܂��B
    :(({params[:on_tree_edge]}))
      �ȗ��BProc �� Method ���w�肷��ƁA���_ (({v})) ����
      ���_ (({w})) �ɐi�񂾎��ɁA
      (({params[:on_tree_edge].call(v, w)})) �����s����܂��B
    :(({params[:adjacent?]}))
      �ȗ��BProc �� Method �Ȃ� (({params[:adjacent?].call(v, w)})) �A
      ����ȊO�Ȃ� (({params[:adjacent?][[v, w]]})) ���Ă΂�A
      ���̖߂�l���U�Ȃ�΁A�� (({[v, w]})) �́u�ʍs�~�߁v�ɂȂ�܂��B
    
    (({params[:target]})) ���w�肳��Ă��āA�����ɓ��B�ł����ꍇ��
    (({true})) ��Ԃ��܂��B
    
--- breadth_first_search(params)
    
    �O���t�ɑ΂��āA���D��T�����s���܂��B
    
    �p�����[�^�͑S�āA�n�b�V�� ((|params|)) �Ɏw�肵�܂��B
    �L���ȃp�����[�^�� (({depth_first_search})) �Ɠ����ł��B
    
    (({params[:target]})) ���w�肳��Ă��āA�����ɓ��B�ł����ꍇ��
    (({true})) ��Ԃ��܂��B
    
--- dijkstra_shortest_paths(params)
    
    �O���t�ɑ΂��āADijkstra�̃A���S���Y���ōŒZ�o�H�����߂܂��B
    
    �ӂ̒���(�d��)�͑S�� 0 �ȏ�łȂ���΂Ȃ�܂���B
    
    �p�����[�^�͑S�āA�n�b�V�� ((|params|)) �Ɏw�肵�܂��B
    �L���ȃp�����[�^���ȉ��Ɏ����܂��B
    
    :(({params[:root]}))
      �K�{�B���̒��_����e���_�ւ̍ŒZ�o�H�����߂܂��B
    :(({params[:target]}))
      �ȗ��B���̒��_�ւ̍ŒZ���������܂�����A�T�����I�����܂��B
      �t�Ɍ����΁A�T�����I���������_�ŁA�w�肳�ꂽ�ȊO�̒��_�ւ�
      �ŒZ�o�H�͋��܂��Ă��Ȃ���������܂���B
      (({params[:target]})) ���ȗ������ꍇ�́A�S�Ă̒��_�ւ̍ŒZ�o�H��
      ���܂��Ă���I�����܂��B
    :(({params[:predecessor]}))
      �ȗ��B Hash ���w�肷��ƁA���� Hash ��
      �u���ꂼ��̒��_�ɍŒZ�o�H�ōs���ɂ́A���O�ɂǂ̒��_��ʂ�΂������v
      ���L�^����܂��B
    :(({params[:distance]}))
      �ȗ��B Hash ���w�肷��ƁA���� Hash ��
      �u (({params[:root]})) ����e���_�ւ̍ŒZ�����v���L�^����܂��B
    :(({params[:on_examine_vertex]}))
      �ȗ��BProc �� Method ���w�肷��ƁA���_ (({v}))
      ���o�R����o�H�̒������n�܂�O�ɁA
      (({params[:on_examine_vertex].call(v)})) �����s����܂��B
    :(({params[:on_relax_edge]}))
      �ȗ��BProc �� Method ���w�肷��ƁA���_ (({w})) �ɍs���o�H���A
      �� (({[v, w]})) ���o�R����o�H�ɕύX�������ɁA
      (({params[:on_relax_edge].call(v, w)})) �����s����܂��B
    :(({params[:adjacent?]}))
      �ȗ��BProc �� Method �Ȃ� (({params[:adjacent?].call(v, w)})) �A
      ����ȊO�Ȃ� (({params[:adjacent?][[v, w]]})) ���Ă΂�A
      ���̖߂�l���U�Ȃ�΁A�� (({[v, w]})) �́u�ʍs�~�߁v�ɂȂ�܂��B
    :(({params[:weight]}))
      �ȗ��BProc �� Method �Ȃ� (({params[:weight].call(v, w)})) �A
      ����ȊO�Ȃ� (({params[:weight][[v, w]]})) ���Ă΂�A
      ���̖߂�l��� (({[v, w]})) �̒���(�d��)�Ƃ݂Ȃ��܂��B
      �ȗ������ꍇ�́A (({self[v, w]})) ���g���܂��B
    :(({params[:zero]}))
      �ȗ��B�u�����[���v��\���I�u�W�F�N�g�ł��B
      �ȗ������ (({0})) �ɂȂ�܂��B�قƂ�ǂ̏ꍇ�͂���Ŗ�薳���ł��傤�B
    :(({params[:infinity]}))
      �ȗ��B�u����������v��\���I�u�W�F�N�g�ł��B
      �ȗ������ (({1.0/0.0})) �ɂȂ�܂��B�قƂ�ǂ̏ꍇ�͂���Ŗ�薳���ł��傤�B
    
    (({params[:target]})) ���w�肳��Ă��āA�����ɓ��B�ł����ꍇ�́A
    (({params[:root]})) ���� (({params[:target]})) �ւ̍ŒZ������Ԃ��܂��B
    
    ����ȊO�̏ꍇ�́A (({nil})) ��Ԃ��܂��B
    
--- warshall_floyd_shortest_paths(params)
    
    �O���t�ɑ΂��āAWarshall Floyd�̃A���S���Y���ōŒZ�o�H�����߂܂��B
    
    ���̒���(�d��)�����ӂ������Ă��\���܂���B
    �܂��A�S���_����S���_�ւ̍ŒZ�o�H����x�ɋ��߂܂��B
    �������A���_����3��ɔ�Ⴕ�Ēx���Ȃ�܂��B
    
    �p�����[�^�͑S�āA�n�b�V�� ((|params|)) �Ɏw�肵�܂��B
    �L���ȃp�����[�^���ȉ��Ɏ����܂��B
    
    :(({params[:predecessor]}))
      �ȗ��B �Ⴆ�Β��_ (({v})) ���璸�_ (({w})) �ɍs���ŒZ�o�H��
      (({[v, x, y, w]})) �������ꍇ�A
        params[:predecessor][[v, w]]= y
        params[:predecessor][[v, y]]= x
        params[:predecessor][[v, x]]= v
      �ƋL�^����܂��B
    :(({params[:distance]}))
      �ȗ��B ���_ (({v})) ���璸�_ (({w})) �ւ̍ŒZ������ (({d}))
      �Ȃ�΁A
        params[:distance][[v, w]]= d
      �ƋL�^����܂��B
    :(({params[:on_examine_edge]}))
      �ȗ��BProc �� Method ���w�肷��ƁA�� (({[v, w]}))
      ���o�R����o�H�̒������n�܂�O�ɁA
      (({params[:on_examine_edge].call(v, w)})) �����s����܂��B
    :(({params[:on_relax_edge]}))
      �ȗ��BProc �� Method ���w�肷��ƁA���_ (({v})) ���璸�_ (({w}))
      �ɍs���o�H���A�� (({[x, w]})) ���o�R����o�H�ɕύX�������ɁA
      (({params[:on_relax_edge].call(v, w, x)})) �����s����܂��B
    :(({params[:adjacent?]}))
      �ȗ��BProc �� Method �Ȃ� (({params[:adjacent?].call(v, w)})) �A
      ����ȊO�Ȃ� (({params[:adjacent?][[v, w]]})) ���Ă΂�A
      ���̖߂�l���U�Ȃ�΁A�� (({[v, w]})) �́u�ʍs�~�߁v�ɂȂ�܂��B
    :(({params[:weight]}))
      �ȗ��BProc �� Method �Ȃ� (({params[:weight].call(v, w)})) �A
      ����ȊO�Ȃ� (({params[:weight][[v, w]]})) ���Ă΂�A
      ���̖߂�l��� (({[v, w]})) �̒���(�d��)�Ƃ݂Ȃ��܂��B
      �ȗ������ꍇ�́A (({self[v, w]})) ���g���܂��B
    :(({params[:zero]}))
      �ȗ��B�u�����[���v��\���I�u�W�F�N�g�ł��B
      �ȗ������ (({0})) �ɂȂ�܂��B�قƂ�ǂ̏ꍇ�͂���Ŗ�薳���ł��傤�B
    :(({params[:infinity]}))
      �ȗ��B�u����������v��\���I�u�W�F�N�g�ł��B
      �ȗ������ (({1.0/0.0})) �ɂȂ�܂��B�قƂ�ǂ̏ꍇ�͂���Ŗ�薳���ł��傤�B
    
    (({nil})) ��Ԃ��܂��B
    
--- maximum_flow(params)
    
    �ӂ̏d�݂�ӂ̗e�ʂƂ݂Ȃ��A���钸�_���炠�钸�_�܂ŁA
    �ő�ǂꂾ�����������ł��邩�����߂܂��B
    
    �p�����[�^�͑S�āA�n�b�V�� ((|params|)) �Ɏw�肵�܂��B
    �L���ȃp�����[�^���ȉ��Ɏ����܂��B
    
    :(({params[:source]}))
      �K�{�B�����ƂȂ钸�_(�\�[�X)���w�肵�܂��B
    :(({params[:sink]}))
      �K�{�B�o���ƂȂ钸�_(�V���N)���w�肵�܂��B
    :(({params[:flow]}))
      �ȗ��B Hash ���w�肷��ƁA���� Hash ��
      �u���ꂼ��̕ӂ̗��ʁv���L�^����܂��B
    :(({params[:rest]}))
      �ȗ��B Hash ���w�肷��ƁA���� Hash ��
      �u���ꂼ��̕ӂɂ��Ƃǂꂾ�������邩�v���L�^����܂��B
    :(({params[:on_add_flow]}))
      �ȗ��BProc �� Method ���w�肷��ƁA���ʂ� (({inc})) �����ǉ����鎞�ɁA
      (({params[:on_add_flow].call(route, inc)})) �����s����܂��B
      (({route})) �͗����o�H��\���܂��B�Ⴆ�Όo�H (({v})) �� (({w})) �� (({x}))
      �Ȃ�A (({route})) �� (({[[v, w], [w, x]]})) �ɂȂ�܂��B
    :(({params[:adjacent?]}))
      �ȗ��BProc �� Method �Ȃ� (({params[:adjacent?].call(v, w)})) �A
      ����ȊO�Ȃ� (({params[:adjacent?][[v, w]]})) ���Ă΂�A
      ���̖߂�l���U�Ȃ�΁A�� (({[v, w]})) �́u�ʍs�~�߁v�ɂȂ�܂��B
    :(({params[:weight]}))
      �ȗ��BProc �� Method �Ȃ� (({params[:weight].call(v, w)})) �A
      ����ȊO�Ȃ� (({params[:weight][[v, w]]})) ���Ă΂�A
      ���̖߂�l��� (({[v, w]})) �̗e��(�d��)�Ƃ݂Ȃ��܂��B
      �ȗ������ꍇ�́A (({self[v, w]})) ���g���܂��B
    :(({params[:zero]}))
      �ȗ��B�u���ʃ[���v��\���I�u�W�F�N�g�ł��B
      �ȗ������ (({0})) �ɂȂ�܂��B�قƂ�ǂ̏ꍇ�͂���Ŗ�薳���ł��傤�B
    
    (({params[:source]})) ���� (({params[:sink]}))
    �܂łɗ��������ł���ő嗬�ʂ�Ԃ��܂��B
    
--- route(target, predecessor[, mode])
    
    (({depth_first_search})) �A (({breadth_first_search})) �A 
    (({djikstra_shortest_paths})) �A (({warshall_floyd_shortest_paths}))
    �� (({params[:predecessor]})) �ɋL�^���ꂽ�������ɁA���_ ((|target|))
    �܂ł̌o�H�����߂ĕԂ��܂��B
    
    �������A (({warshall_floyd_shortest_paths})) �̏ꍇ�́A ((|target|))
    �� [�n�_, �I�_] �Ƃ����z����w�肵�܂��B
    
    ((|predecessor|)) �ɂ́A (({params[:predecessor]})) �Ɏw�肵�� Hash
    ���w�肵�܂��B
    
    ((|mode|)) �� (({:vertex})) (�f�t�H���g)���w�肷��ƌo�H��̒��_���A
    (({:edge})) ���w�肷��ƌo�H��̕ӂ�Ԃ��܂��B
    
--- graphviz_format(params)
    
    �O���t��((<Graphviz|URL:http://www.graphviz.org/>))��DOT�`���ŏo�͂��܂��B
    ���̃��\�b�h�̏o�͂�((<Graphviz|URL:http://www.graphviz.org/>))��dot�R�}���h��
    ���͂���ƁA�O���t�����o���ł��܂��B
    
    �p�����[�^�͑S�āA�n�b�V�� ((|params|)) �Ɏw�肵�܂��B
    �L���ȃp�����[�^���ȉ��Ɏ����܂��B
    
    :(({params[:io]}))
      �ȗ��B�o�͐�� IO �I�u�W�F�N�g�B
    :(({params[:graph_id]}))
      �ȗ��B�O���t��ID�Ƃ��Ďg���镶����B
    :(({params[:vertex_id]}))
      �ȗ��B Proc �� Method �� Hash ���w��B
      (({params[:vertex_id][v]})) �����_ (({v})) ��ID�Ƃ��Ďg���܂��B
      �ȗ�����ƁA (({v.to_s()})) ���g���܂��B
      
      ID�Ɏg���镶���ɂ͐������L��܂��B
      ((<The DOT Language|URL:http://www.graphviz.org/cvs/doc/info/lang.html>))
      ���Q�Ƃ��Ă��������B
    :(({params[:vertex_attribute]}))
      �ȗ��B Proc �� Method �� Hash ���w��B
      (({params[:vertex_attribute][v]})) �����_ (({v}))
      �̑�����\�� Hash �Ƃ��Ďg���܂��B
    :(({params[:edge_label]}))
      �ȗ��B Proc �� Method �� Hash ���w��B
      (({params[:edge_label].call(v, w)})) (Hash�̏ꍇ��
      (({params[:edge_label][[v, w]]})) )���� (({[v, w]}))
      �̃��x���Ƃ��Ďg���܂��B
    :(({params[:edge_attribute]}))
      �ȗ��B Proc �� Method �� Hash ���w��B
      (({params[:edge_attribute].call(v, w)})) (Hash�̏ꍇ��
      (({params[:edge_attribute][[v, w]]})) )���� (({[v, w]}))
      �̑�����\�� Hash �Ƃ��Ďg���܂��B
    :(({params[:extra]}))
      �ȗ��B�O���t�̒ǉ��̑����Ȃǂ��w�肵�܂��B���̕������
        (graph|digraph) [ID] '{'
      �̒���ɂ��̂܂܏o�͂���܂��B
    
    (({params[:io]})) ���w�肳�ꂽ�ꍇ�� (({params[:io]}))
    ���A�����łȂ���Ώo�͓��e�𕶎���ŕԂ��܂��B
    
=end
