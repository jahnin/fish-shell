# Install fish
```
sudo apk add fish

(1/7) Installing readline (8.2.10-r0)
(2/7) Installing bc (1.07.1-r4)
(3/7) Installing libpcre2-32 (10.43-r0)
(4/7) Installing libstdc++ (13.2.1_git20240309-r1)
(5/7) Installing fish (3.7.1-r0)
Executing fish-3.7.1-r0.post-install
(6/7) Installing docker-fish-completion (26.1.5-r0)
(7/7) Installing curl-fish-completion (8.12.1-r0)
Executing busybox-1.36.1-r29.trigger
```

# Change default shell to fish

#### Edit /etc/passwd manually. An example line for a user named user is:
```
Contents of /etc/passwd
...
user:x:1000:1000:user:/home/user:/bin/ash
...
Change /bin/ash to point to the path of a shell from /etc/shells. 
```

#### Using shadow
```
# apk add shadow

And use chsh:

# chsh username
```

# Install Git
```
apk add git
(1/3) Installing libexpat (2.7.0-r0)
(2/3) Installing git (2.45.3-r0)
(3/3) Installing git-init-template (2.45.3-r0)
Executing busybox-1.36.1-r29.trigger
```

# Install oh my fish
```
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
```

# Install bobthefish theme
```
omf install bobthefish                                                                                                                                                                                                                                                                                                      16:49:57
Updating https://github.com/oh-my-fish/packages-main master... Done!
Installing package bobthefish
```
