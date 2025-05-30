### NCP 베어메탈 서버group 생성

- ver0.2  
**Server Group 설정**
Group 명도 임의로 설정 가능함
`count`(int)              = 해당 group의 서버 수 (0으로 설정시 생성 X)  
`image_filter`(string)    = "CentOS 7.8" | "Red Hat Enterprise Linux 8.1" | "Windows Server 2016" \  
                            "Ubuntu Server 20.04" | "Ubuntu Server 22.04" | "Windows Server 2019" \  
                            "Rocky Linux 8.6" | "Rocky Linux 8.10" | "Windows Server 2022"  
`cpu_count`(int)          = 8 | 24 | 36 | 48  
`raid_type_name`(string)  = "1" (RAID 1+0) | "5" (RAID 5)  
`subnet_type`(string)     = 해당 group을 배치하고자 하는 subnet ("pub_dmz" | "pri_svc" | "pri_db")  
  
> ACG 생성은 가능하나, Server에 추가할 수 없음  
> - classic 에서만 지원  