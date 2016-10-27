function [self] = RSXLHotellings1()

self.www  = 'http://www.real-statistics.com/multivariate-statistics/hotellings-t-square-statistic/one-sample-hotellings-t-square/';
self.Y = [
[6, 8, 3, 5, 19],
[6, 7, 3, 4, 9],
[5, 7, 1, 4, 16],
[10, 9, 8, 4, 4],
[7, 9, 7, 6, 9],

[6, 6, 3, 9, 17],
[5, 8, 6, 7, 6],
[3, 7, 3, 6, 16],
[8, 8, 9, 3, 8],
[8, 6, 5, 3, 13],

[5, 9, 5, 4, 17],
[8, 8, 2, 3, 5],
[5, 8, 7, 5, 8],
[4, 9, 10, 2, 16],
[2, 9, 4, 10, 14],

[7, 5, 8, 6, 15],
[4, 8, 8, 2, 16],
[5, 10, 9, 3, 11],
[7, 7, 3, 7, 12],
[1, 5, 2, 7, 17],

[5, 6, 7, 7, 20],
[4, 3, 1, 2, 15],
[7, 9, 6, 6, 9],
[4, 5, 2, 4, 12],
[8, 9, 5, 7, 18],
]; %#ok<*COMNL>
self.mu   = [7, 8, 5, 7, 9];
self.z    = 52.6724;
self.df   = [5, 24];
self.p    = 0.000155;
end





