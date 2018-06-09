clear;
%�����ǩ����
f = fopen('vericode-map.txt');
labelList = fscanf(f, '%s');
fclose(f);
%labelList=importdata('vericode-map.txt');

%����Ϊcpuģʽ��gpuģʽ�����ã��������±���
caffe.set_mode_cpu();
%gpu_id=0;
%caffe.set_mode_gpu();	
%caffe.set_device(gpu_id);

%��������
net = caffe.Net('vericode-nin.prototxt', 'nin_iter_5000.caffemodel','test');
img = imread('1A2I.bmp');

%��Ϊ����Ҫ��ͼ����224*224�ģ�����������Ҫresize
img = imresize(img, [224 224]);

%��Ϊcaffe��BGR�ģ�matlab��RGB�ģ�����Ҫ�л�ͨ��
img = img(:, :, [3, 2, 1]);

%��Ϊcaffe�����з�ʽ�������У����ڴ����ݵ�ǰn���ֽ�ȫ��һ�е����ݣ���matlab���÷���������������
%��������Ҫ�����е���
img = permute(img, [2, 1, 3]);

%����������ʶ��
result = net.forward({img});
labelResult = '';

%��Ϊ�Ƕ����ǩ�����������ѭ��ȡ����
for i = 1:size(result, 1)
    [conf, label] = max(result{i});
    labelResult = [labelResult labelList(label)];
end
sprintf('ʶ������%s', labelResult)