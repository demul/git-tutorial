function [  ] = drawBox( y, x, h ,w )
%DRAWBOX 이 함수의 요약 설명 위치
%   자세한 설명 위치
line([x, x], [y, y+h], 'color', 'r', 'linewidth', 2);
line([x, x+w], [y, y], 'color', 'r', 'linewidth', 2);
line([x+w, x], [y+h, y+h], 'color', 'r', 'linewidth', 2);
line([x+w, x+w], [y, y+h], 'color', 'r', 'linewidth', 2);

end

