require "graph"


#4�̒��_0, 1, 2, 3���������O���t�����B
g= UndirectedHashGraph.new([0, 1, 2, 3])

#��[0, 1], [0, 2], [1, 3], [2, 3]�����A�e�ӂ̏d�݂�ݒ�B
g[0, 1]= 1.0
g[0, 2]= 2.0
g[1, 3]= 3.0
g[2, 3]= 4.0

#�e�ӂ̏d�݂��u�ӂ̒����v�Ƃ݂Ȃ��āA���_0���璸�_3�ւ̍ŒZ�o�H�����߂Ă݂�B
printf("[dijkstra_shortest_paths]\n")
dist= g.dijkstra_shortest_paths({
  :root        => 0,           #���_0����X�^�[�g�B
  :target      => 3,           #���_3���S�[���B
  :predecessor => (preds= {}), #�o�H�̏���preds�Ƃ���Hash�ɋL�^�B
})
route= g.route(3, preds)       #preds�̏�񂩂�A���_3�ւ̌o�H�����o���B
printf("The shortest route from 0 to 3 is %p, distance is %p.\n\n", route, dist)

#�e�ӂ̏d�݂��u�ӂ̗e�ʁv�Ƃ݂Ȃ��āA���_0���璸�_3�܂ŗ�����ő嗬�ʂ����߂Ă݂�B
printf("[maximum_flow]\n")
total= g.maximum_flow({
  :source => 0,          #�����͒��_0�B
  :sink   => 3,          #�o���͒��_3�B
  :flow   => (flow= {}), #�e�ӂ̗��ʂ�flow�Ƃ���Hash�ɋL�^�B
})
printf("The maximum flow is %p.\nThe flow of each edge is %p.\n\n", total, flow)

#�[���D��T���őS���_�����񂵂Ă݂�B
printf("[depth_first_search]  ")
g.depth_first_search({
  :root         => 0,    #���_0����X�^�[�g�B
  :on_tree_edge => proc{ |v, w| printf("%d->%d  ", v, w) },
                         #�V�������_�ɐi�ނ��тɂ���Proc���Ă΂��B
})
printf("\n\n")

#���D��T���őS���_�����񂵂Ă݂�B
printf("[breadth_first_search]  ")
g.breadth_first_search({
  :root         => 0,    #���_0����X�^�[�g�B
  :on_tree_edge => proc{ |v, w| printf("%d->%d  ", v, w) },
                         #�V�������_�ɐi�ނ��тɂ���Proc���Ă΂��B
})
printf("\n\n")

#�S���_����S���_�ւ̍ŒZ�o�H����x�ɋ��߂Ă݂�B
printf("[warshall_floyd_shortest_paths]\n")
dist= g.warshall_floyd_shortest_paths({
  :predecessor => (preds= {}), #�o�H�̏���preds�Ƃ���Hash�ɋL�^�B
  :distance    => (dists= {}), #�e���_�Ԃ̍ŒZ������dists�Ƃ���Hash�ɋL�^�B
})
g.each_vertex do |v|
  g.each_vertex do |w|
    next if v==w
    route= g.route([v, w], preds)
      #preds�̏�񂩂�A���_v���璸�_w�ւ̌o�H�����o���B
    printf("The shortest route from %d to %d is %p, distance is %p.\n",
      v, w, route, dists[[v, w]])
  end
end
