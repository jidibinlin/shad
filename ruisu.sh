#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH


#�������
#��Ȩ�ļ��Զ�����url
APX=http://rs.91yun.pw/apx1.php
#��װ�����ص�ַ
INSTALLPACK=https://github.com/91yun/serverspeeder/blob/test/91yunserverspeeder.tar.gz?raw=true
#�жϰ汾֧������ĵ�ַ
CHECKSYSTEM=https://raw.githubusercontent.com/91yun/serverspeeder/test/serverspeederbin.txt
#bin���ص�ַ
BIN=downloadurl



#ȡ����ϵͳ������
Get_Dist_Name()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
	else
        DISTRO='unknow'
    fi
    Get_OS_Bit
}

Get_OS_Bit()
{
    if [[ `getconf WORD_BIT` = '32' && `getconf LONG_BIT` = '64' ]] ; then
        ver3='x64'
    else
        ver3='x32'
    fi
}

Get_Dist_Name

#��װ��Ӧ�����
if [ "$DISTRO" == "CentOS" ];then
	yum install -y redhat-lsb curl net-tools
elif [ "$DISTRO" == "Debian" ];then
	apt-get update
	apt-get install -y lsb-release curl
elif [ "$DISTRO" == "Raspbian" ];then
	apt-get update
	apt-get install -y lsb-release curl
elif [ "$DISTRO" == "Ubuntu" ];then
	apt-get update
	apt-get install -y lsb-release curl
else
	echo "һ���ű���ʱֻ֧��centos��ubuntu��debian�İ�װ������ϵͳ��ѡ���ֶ���װhttp://www.91yun.org/serverspeeder91yun"
	exit 1
fi

release=$DISTRO
#���а汾
if [ "$release" == "Debian" ]; then
	ver1str="lsb_release -rs | awk -F '.' '{ print \$1 }'"
else
	ver1str="lsb_release -rs | awk -F '.' '{ print \$1\".\"\$2 }'"
fi
ver1=$(eval $ver1str)
#ver11=`echo $ver1 | awk -F '.' '{ print $1 }'`

#�ں˰汾
ver2=`uname -r`
#���ٰ汾
ver4=3.10.61.0

echo "================================================="
echo "����ϵͳ��$release "
echo "���а汾��$ver1 "
echo "�ں˰汾��$ver2 "
echo "λ����$ver3 "
echo "���ٰ汾��$ver4 "
echo "================================================="


#����֧�ֵ�bin�б�
curl "http://soft.91yun.org/soft/serverspeeder/serverspeederbin.txt" -o serverspeederbin.txt || { echo "�ļ�����ʧ�ܣ��Զ��˳�������ǰ��http://www.91yun.org/serverspeeder91yun�ֶ����ذ�װ��";exit 1; }




#�ж��ں˰汾
grep -q "$release/$ver11[^/]*/$ver2/$ver3" serverspeederbin.txt
if [ $? == 1 ]; then
		#echo "û���ҵ��ں�"
	if [ "$release" == "CentOS" ]; then
		ver21=`echo $ver2 | awk -F '-' '{ print $1 }'`
		ver22=`echo $ver2 | awk -F '-' '{ print $2 }' | awk -F '.' '{ print $1 }'`
		#cat serverspeederbin.txt | grep -q  "$release/$ver1/$ver21-$ver22[^/]*/$ver3/"
		cat serverspeederbin.txt | grep -q  "$release/$ver11[^/]*/$ver21-$ver22[^/]*/$ver3/"

		if [ $? == 1 ]; then
			echo -e "\r\n"
			echo "�����ݲ�֧�ָ��ںˣ������˳�.�Զ���װ�жϱȽ��ϸ�����Ե�http://www.91yun.org/serverspeeder91yun�ֶ����ذ�װ�ļ����Բ�ͬ�汾"
			exit 1
		fi
		echo "û����ȫƥ����ںˣ���ѡһ����ӽ��ĳ��ԣ���ȷ��һ���ɹ�,(����а汾���ظ���ѡ�����ѡһ���Ϳ���)"
		echo -e "����ǰ���ں�Ϊ \033[41;37m $ver2 \033[0m"
		cat serverspeederbin.txt | grep  "$release/$ver11[^/]*/$ver21-$ver22[^/]*/$ver3/"  | awk -F '/' '{ print NR"��"$3 }'
	fi


	if [[ "$release" == "Ubuntu" ]] || [[ "$release" == "Debian" ]]; then
		ver21=`echo $ver2 | awk -F '-' '{ print $1 }'`
		ver22=`echo $ver2 | awk -F '-' '{ print $2 }'`
		cat serverspeederbin.txt | grep -q  "$release/$ver11[^/]*/$ver21(-)?$ver22[^/]*/$ver3/"

		if [ $? == 1 ]; then
			echo -e "\r\n"
			echo "�����ݲ�֧�ָ��ںˣ������˳�.�Զ���װ�жϱȽ��ϸ�����Ե�http://www.91yun.org/serverspeeder91yun�ֶ����ذ�װ�ļ����Բ�ͬ�汾"
			exit 1
		fi
		echo "û����ȫƥ����ںˣ���ѡһ����ӽ��ĳ��ԣ���ȷ��һ���ɹ�,(����а汾���ظ���ѡ�����ѡһ���Ϳ���)"
		echo -e "����ǰ���ں�Ϊ \033[41;37m $ver2 \033[0m"
		cat serverspeederbin.txt | grep  "$release/$ver11[^/]*/$ver21(-)?$ver22[^/]*/$ver3/"  | awk -F '/' '{ print NR"��"$3 }'
	fi


	echo "��ѡ������������ţ���"
	read cver2
	if [ "$cver2" == "" ]; then
		echo "δѡ���κ��ں˰汾���ű��˳�"
		exit 1
	fi

	if [ "$release" == "CentOS" ]; then
		cver2str="cat serverspeederbin.txt | grep  \"$release/$ver11[^/]*/$ver21-$ver22[^/]*/$ver3/\"  | awk -F '/' '{ print NR\"��\"\$3 }' | awk -F '��' '/"$cver2��"/{ print \$2 }' | awk 'NR==1{print \$1}'"
	fi
	if [[ "$release" == "Ubuntu" ]] || [[ "$release" == "Debian" ]]; then
		cver2str="cat serverspeederbin.txt | grep  \"$release/$ver11[^/]*/$ver21-[^/]*/$ver3/\"  | awk -F '/' '{ print NR\"��\"\$3 }' | awk -F '��' '/"$cver2��"/{ print \$2 }' awk 'NR==1{print \$1}'"
	fi
	ver2=$(eval $cver2str)
	if [ "$ver2" == "" ]; then
        echo "�ű���ò����ں˰汾�ţ������˳�"
		exit 1
    fi
	#������ѡ���ں˰汾���ٻ�ͷȷ����汾

fi
#�ж����ٰ汾
grep -q "$release/$ver1/$ver2/$ver3/$ver4" serverspeederbin.txt
if [ $? == 1 ]; then
	grep -q "$release/$ver11[^/]*/$ver2/$ver3/$ver4" serverspeederbin.txt
	if [ $? == 1 ]; then
		echo -e "\r\n"
		echo -e "�����õ����ٰ�װ�ļ���\033[41;37m 3.10.60.0  \033[0m��������ں�û��ƥ��ģ���ѡ��һ���ӽ������ٰ汾�ų��ԣ���ȷ��һ������,(����а汾���ظ���ѡ�����ѡһ���Ϳ���)"
		cat serverspeederbin.txt | grep  "$release/$ver11[^/]*/$ver2/$ver3/"  | awk -F '/' '{ print NR"��"$5 }'
		echo "��ѡ�����ٰ汾�ţ�����������ţ���"
			read cver4
		if [ "$cver4" == "" ]; then
			echo "δѡ���κ����ٰ汾���ű��˳�"
			exit 1
		fi
			cver4str="cat serverspeederbin.txt | grep  \"$release/$ver11[^/]*/$ver2/$ver3/\"  | awk -F '/' '{ print NR\"��\"\$5 }' | awk -F '��' '/"$cver4��"/{ print \$2 }' | awk 'NR==1{print \$1}'"
			ver4=$(eval $cver4str)
		if [ "$ver4" == "" ]; then
			echo "ûȡ�����ٰ汾����������˳���"
			exit 1
		fi
	fi
	#�������ٰ汾���ں˰汾���ٻ�ͷȷ��ʹ�õĴ�汾��
	cver1str="cat serverspeederbin.txt | grep '$release/$ver11[^/]*/$ver2/$ver3/$ver4' | awk -F '/' 'NR==1{ print \$2 }'"
	ver1=$(eval $cver1str)
fi



BINFILESTR="cat serverspeederbin.txt | grep '$release/$ver1/$ver2/$ver3/$ver4/0' | awk -F '/' '{ print \$7 }'"
BINFILE=$(eval $BINFILESTR)
BIN="http://soft.91yun.org/soft/serverspeeder/bin/$release/$ver1/$ver2/$ver3/$ver4/$BINFILE"
echo $BIN
rm -rf serverspeederbin.txt





#��ȡ����ip������ȡ��ip���������Ȼ��ͨ���������mac��ַ��
# if [ "$1" == "" ]; then
	# IP=$(curl ipip.net | awk -F ' ' '{print $2}' | awk -F '��' '{print $2}')
	# NC="ifconfig | awk -F ' |:' '/$IP/{print a}{a=\$1}'"
	# NETCARD=$(eval $NC)
# else
	# NETCARD=eth0
# fi
# MACSTR="LANG=C ifconfig $NETCARD | awk '/HWaddr/{ print \$5 }' "
# MAC=$(eval $MACSTR)
# if [ "$MAC" = "" ]; then
# MACSTR="LANG=C ifconfig $NETCARD | awk '/ether/{ print \$2 }' "
# MAC=$(eval $MACSTR)
# fi
# echo IP=$IP
# echo NETCARD=$NETCARD

if [ "$1" == "" ]; then
	MACSTR="LANG=C ifconfig eth0 | awk '/HWaddr/{ print \$5 }' "
	MAC=$(eval $MACSTR)
	if [ "$MAC" == "" ]; then
		MACSTR="LANG=C ifconfig eth0 | awk '/ether/{ print \$2 }' "
		MAC=$(eval $MACSTR)
	fi
	if [ "$MAC" == "" ]; then
		#MAC=$(ip link | awk -F ether '{print $2}' | awk NF | awk 'NR==1{print $1}')
		echo "���ƽ�ֻ֧��eth0������������������������eth0,���޸�������"
		exit 1
	fi
else
	MAC=$1
fi
echo MAC=$MAC

#����Զ�ȡ������Ҫ���ֶ�����
if [ "$MAC" = "" ]; then
echo "�޷��Զ�ȡ��mac��ַ�����ֶ����룺"
read MAC
echo "�ֶ������mac��ַ��$MAC"
fi


#���ذ�װ��
echo "======================================"
echo "��ʼ���ذ�װ����������"
echo "======================================"
wget -N --no-check-certificate -O 91yunserverspeeder.tar.gz  $INSTALLPACK
tar xfvz 91yunserverspeeder.tar.gz || { echo "���ذ�װ��ʧ�ܣ�����";exit 1; }

#������Ȩ�ļ�
echo "======================================"
echo "��ʼ������Ȩ�ļ���������"
echo "======================================"
curl "$APX?mac=$MAC" -o 91yunserverspeeder/apxfiles/etc/apx-20341231.lic || { echo "������Ȩ�ļ�ʧ�ܣ�����$APX?mac=$MAC";exit 1;}


#ȡ�����к�
echo "======================================"
echo "��ʼ�޸������ļ���������"
echo "======================================"
SNO=$(curl "$APX?mac=$MAC&sno") || { echo "�������к�ʧ�ܣ�����";exit 1; }
echo "���кţ�$SNO"
sed -i "s/serial=\"sno\"/serial=\"$SNO\"/g" 91yunserverspeeder/apxfiles/etc/config
rv=$release"_"$ver1"_"$ver2
sed -i "s/Debian_7_3.2.0-4-amd64/$rv/g" 91yunserverspeeder/apxfiles/etc/config
# sed -i "s/accppp=\"1\"/accppp=\"0\"/g" 91yunserverspeeder/apxfiles/etc/config

#����bin�ļ�
echo "======================================"
echo "��ʼ����bin�����ļ���������"
echo "======================================"
curl $BIN -o "91yunserverspeeder/apxfiles/bin/acce-3.10.61.0-["$release"_"$ver1"_"$ver2"]" || { echo "����bin�����ļ�ʧ�ܣ�����";exit 1; }

#�л�Ŀ¼ִ��װ�ļ�
cd 91yunserverspeeder

# Restore license permission to read and write if it exist for re-install.
if [ -f /serverspeeder/etc/apx-20341231.lic ]; then
    chattr -i /serverspeeder/etc/apx-20341231.lic
fi

bash install.sh

#��ֹ�޸���Ȩ�ļ�
chattr +i /serverspeeder/etc/apx*
#CentOS7��ӿ�������
# if [ "$release" == "CentOS" ] && [ "$ver11" == "7" ]; then
	# chmod +x /etc/rc.d/rc.local
	# echo "/serverspeeder/bin/serverSpeeder.sh start" >> /etc/rc.local
# fi
#��װ����ʾ״̬
bash /serverspeeder/bin/serverSpeeder.sh status