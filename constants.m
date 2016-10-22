classdef constants
    %CONSTANTS このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties (Constant)
        MIN_TIME_INTERVAL = 1e-9
        c=2.99792458e8
        % IEEE 802.11 modulation table
        IEEE802_11ModuTable = struct(   'BPSK',1,   'QPSK',2,  'QAM16',3,   'QAM64',4,    ...  % this row use as index for find mode fast;
                                     'mode',{'BPSK',    'QPSK',     'QAM16',    'QAM64' },...
                                   'SINRdB',{   5,         8,         15,         25    },...
                                     'SINR',{3.1623,    6.3096,     31.6228,    316.2278},...
                                    'NDBPS',{  24,        48,         96,         192   });%Data Bits Per Symbol
    end        
end

