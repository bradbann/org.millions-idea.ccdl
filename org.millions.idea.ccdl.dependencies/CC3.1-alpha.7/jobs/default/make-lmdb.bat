@echo off

title ����ǵ�һ��ִ�У����Ƚ�ѹyzm-easy.rarȻ����ִ��

set tips_info=0
if exist train_lmdb set tips_info=1
if exist val_lmdb set tips_info=1

if %tips_info% == 1 (
    echo ȷ��Ҫ���������������ɾ������Ŀ¼�ģ�����ֹ������Ѻò����״�����ɾ������
    pause
)


if exist train_lmdb rd /q /s train_lmdb
if exist val_lmdb rd /q /s val_lmdb

rem ���Ҫ���ͼ��ߴ�ģ����磬���ԼӲ���--resize_width=224 --resize_height=224
rem ���Ҫ������ͼ��Ū�ɵ�ͨ���Ҷ�ͼ�����ԼӲ���--gray=true
rem ����ָ��Ϊ--db_mode=append����--db_mode=new����ʾ������ݺʹ��������ݿ�

echo ����ѵ�����ݿ�train_lmdb...
"..\..\bin\convert_imageset.exe" "" label-train.txt train_lmdb --shuffle=true --resize_width=120 --resize_height=30
echo ������֤���ݿ�train_lmdb...
"..\..\bin\convert_imageset.exe" "" label-val.txt val_lmdb --shuffle=true  --resize_width=120 --resize_height=30
echo LMDB���ݿⴴ����ϡ�
pause