function func = input_linear( ~ )
%INPUT_LINEAR 线性函数输入
% 创建对话框，输入并获取拉伸灰度区间，线性函数的k与b值
    prompt = {'Please enter lower limit:','Please enter upper limit:','Please enter k:','Please enter b'};
    func = inputdlg(prompt,'Linear Parameter',1,{'0','100','1','0'},'on');
end