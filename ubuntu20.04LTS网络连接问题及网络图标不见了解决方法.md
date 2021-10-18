# ubuntu20.04LTS网络连接问题及网络图标不见了解决方法


#停止网络服务管理

```
sudo service network-manager stop
```


#删除原有配置

```
sudo rm /var/lib/NetworkManager/NetworkManager.state
```


#重启网络服务

```
sudo service network-manager start
```


#编辑管理策略

```
sudo gedit /etc/NetworkManager/NetworkManager.conf
```


（把false改成true）
#重启网络服务

```
sudo service network-manager restart

```

即可恢复正常

