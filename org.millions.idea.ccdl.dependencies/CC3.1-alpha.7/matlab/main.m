clear;
%�����ǩ����
labelList=importdata('label-map.txt');

%����Ϊcpuģʽ��gpuģʽ�����ã��������±���
caffe.set_mode_cpu();
%gpu_id=0;
%caffe.set_mode_gpu();	
%caffe.set_device(gpu_id);

%��������
net = caffe.Net('nin-depoy.prototoxt', 'nin_imagenet.caffemodel','test');
img = imread('car.jpg');

%��Ϊ����Ҫ��ͼ����224*224�ģ�����������Ҫresize
img = imresize(img, [224 224]);

%��Ϊcaffe��BGR�ģ�matlab��RGB�ģ�����Ҫ�л�ͨ��
img = img(:, :, [3, 2, 1]);

%��Ϊcaffe�����з�ʽ�������У����ڴ����ݵ�ǰn���ֽ�ȫ��һ�е����ݣ���matlab���÷���������������
%��������Ҫ�����е���
img = permute(img, [2, 1, 3]);

%����������ʶ��
result = net.forward({img});

%�õ�softmax�����ֵ���Ϊʶ����
[conf, label] = max(result{1});

%������
sprintf('ʶ�������Ǹ���%s�����Ŷȣ�%.3f', labelList{label}, conf)