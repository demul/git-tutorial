function [  ] = drawBox( y, x, h ,w )
%DRAWBOX �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
line([x, x], [y, y+h], 'color', 'r', 'linewidth', 2);
line([x, x+w], [y, y], 'color', 'r', 'linewidth', 2);
line([x+w, x], [y+h, y+h], 'color', 'r', 'linewidth', 2);
line([x+w, x+w], [y, y+h], 'color', 'r', 'linewidth', 2);

end

