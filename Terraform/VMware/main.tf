terraform {                                                                                                                                                                                
  required_providers {                                                                                                                                                                     
    vsphere = {                                                                                                                                                                            
      source = "hashicorp/vsphere"                                                                                                                                                         
      version = "2.5.1"                                                                                                                                                                    
   }                                                                                                                                                                                       
 }                                                                                                                                                                                         
}                                                                                                                                                                                          
                                                                                                                                                                                           
provider "vsphere" {                                                                                                                                                                       
    user                 = "user"                                                                                                                                
    password             = "password"                                                                                                                                                    
    vsphere_server       = "hostname"                                                                                                                                                  
    allow_unverified_ssl = true                                                                                                                                                            
}                                                                                                                                                                                          
                                                                                                                                                                                           
data "vsphere_datacenter" "datacenter" {                                                                                                                                                   
  name = "Homelab"                                                                                                                                                                         
}                                                                                                                                                                                          
                                                                                                                                                                                           
data "vsphere_datastore" "datastore" {                                                                                                                                                     
  name          = "datastore1"                                                                                                                                                             
  datacenter_id = data.vsphere_datacenter.datacenter.id                                                                                                                                    
}                                                                                                                                                                                          
                                                                                                                                                                                           
data "vsphere_compute_cluster" "cluster" {                                                                                                                                                 
  name          = "Prod-01"                                                                                                                                                                
  datacenter_id = data.vsphere_datacenter.datacenter.id                                                                                                                                    
}                                                                                                                                                                                          
                                                                                                                                                                                           
data "vsphere_network" "network" {                                                                                                                                                         
  name          = "VM Network"                                                                                                                                                             
  datacenter_id = data.vsphere_datacenter.datacenter.id                                                                                                                                    
}                                                                                                                                                                                          
                                                                                                                                                                                           
resource "vsphere_virtual_machine" "vm1" {                                                                                                                                                 
  name             = "KubeNode1"                                                                                                                                                           
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id                                                                                                                 
  datastore_id     = data.vsphere_datastore.datastore.id                                                                                                                                   
  num_cpus         = 4                                                                                                                                                                     
  memory           = 8096                                                                                                                                                                  
  guest_id         = "other3xLinux64Guest"                                                                                                                                                 
  network_interface {                                                                                                                                                                      
    network_id = data.vsphere_network.network.id                                                                                                                                           
  }                                                                                                                                                                                        
  disk {                                                                                                                                                                                   
    label = "disk0"                                                                                                                                                                        
    size  = 128                                                                                                                                                                            
  }                                                                                                                                                                                        
} 
