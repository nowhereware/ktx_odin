package ktx_odin

import vk "vendor:vulkan"

VulkanFunctions :: struct {
	vkGetInstanceProcAddr:                    vk.ProcGetInstanceProcAddr,
	vkGetDeviceProcAddr:                      vk.ProcGetDeviceProcAddr,
	vkAllocateCommandBuffers:                 vk.ProcAllocateCommandBuffers,
	vkAllocateMemory:                         vk.ProcAllocateMemory,
	vkBeginCommandBuffer:                     vk.ProcBeginCommandBuffer,
	vkBindBufferMemory:                       vk.ProcBindBufferMemory,
	vkBindImageMemory:                        vk.ProcBindImageMemory,
	vkCmdBlitImage:                           vk.ProcCmdBlitImage,
	vkCmdCopyBufferToImage:                   vk.ProcCmdCopyBufferToImage,
	vkCmdPipelineBarrier:                     vk.ProcCmdPipelineBarrier,
	vkCreateImage:                            vk.ProcCreateImage,
	vkDestroyImage:                           vk.ProcDestroyImage,
	vkCreateBuffer:                           vk.ProcCreateBuffer,
	vkDestroyBuffer:                          vk.ProcDestroyBuffer,
	vkCreateFence:                            vk.ProcCreateFence,
	vkDestroyFence:                           vk.ProcDestroyFence,
	vkEndCommandBuffer:                       vk.ProcEndCommandBuffer,
	vkFreeCommandBuffers:                     vk.ProcFreeCommandBuffers,
	vkFreeMemory:                             vk.ProcFreeMemory,
	vkGetBufferMemoryRequirements:            vk.ProcGetBufferMemoryRequirements,
	vkGetImageMemoryRequirements:             vk.ProcGetImageMemoryRequirements,
	vkGetImageSubresourceLayout:              vk.ProcGetImageSubresourceLayout,
	vkGetPhysicalDeviceImageFormatProperties: vk.ProcGetPhysicalDeviceImageFormatProperties,
	vkGetPhysicalDeviceFormatProperties:      vk.ProcGetPhysicalDeviceFormatProperties,
	vkGetPhysicalDeviceMemoryProperties:      vk.ProcGetPhysicalDeviceMemoryProperties,
	vkMapMemory:                              vk.ProcMapMemory,
	vkQueueSubmit:                            vk.ProcQueueSubmit,
	vkQueueWaitIdle:                          vk.ProcQueueWaitIdle,
	vkUnmapMemory:                            vk.ProcUnmapMemory,
	vkWaitForFences:                          vk.ProcWaitForFences,
}

VulkanTexture :: struct {
	vkDestroyImage: vk.ProcDestroyImage,
	vkFreeMemory:   vk.ProcFreeMemory,
	image:          vk.Image,
	imageFormat:    vk.Format,
	imageLayout:    vk.ImageLayout,
	deviceMemory:   vk.DeviceMemory,
	viewType:       vk.ImageViewType,
	width:          u32,
	height:         u32,
	depth:          u32,
	levelCount:     u32,
	layerCount:     u32,
	allocationId:   u64,
}

VulkanTexture_subAllocatorAllocMem :: #type proc "system" (
	allocInfo: ^vk.MemoryAllocateInfo,
	memReq: ^vk.MemoryRequirements,
	pageCount: ^u64,
) -> u64
VulkanTexture_subAllocatorBindBuffer :: #type proc "system" (buffer: vk.Buffer, allocId: u64) -> vk.Result
VulkanTexture_subAllocatorBindImage :: #type proc "system" (image: vk.Image, allocId: u64) -> vk.Result
VulkanTexture_subAllocatorMemoryMap :: #type proc "system" (
	allocId: u64,
	pageNumber: u64,
	mapLength: ^vk.DeviceSize,
	dataPtr: ^rawptr,
) -> vk.Result
VulkanTexture_subAllocatorMemoryUnmap :: #type proc "system" (allocId: u64, pageNumber: u64)
VulkanTexture_subAllocatorFreeMem :: #type proc "system" (allocId: u64)

VulkanTexture_subAllocatorCallbacks :: struct {
	allocMemFuncPtr:    VulkanTexture_subAllocatorAllocMem,
	bindBufferFuncPtr:  VulkanTexture_subAllocatorBindBuffer,
	bindImageFuncPtr:   VulkanTexture_subAllocatorBindImage,
	memoryMapFuncPtr:   VulkanTexture_subAllocatorMemoryMap,
	memoryUnmapFuncPtr: VulkanTexture_subAllocatorMemoryUnmap,
	freeMemFuncPtr:     VulkanTexture_subAllocatorFreeMem,
}

VulkanDeviceInfo :: struct {
	instance:               vk.Instance,
	physicalDevice:         vk.PhysicalDevice,
	device:                 vk.Device,
	queue:                  vk.Queue,
	cmdBuffer:              vk.CommandBuffer,
	cmdPool:                vk.CommandPool,
	pAllocator:             ^vk.AllocationCallbacks,
	deviceMemoryProperties: vk.PhysicalDeviceMemoryProperties,
	vkFuncs:                VulkanFunctions,
}

@(default_calling_convention = "system", link_prefix = "ktx")
foreign lib {
	VulkanTexture_Destruct_WithSuballocator :: proc(this: ^VulkanTexture, device: vk.Device, pAllocator: ^vk.AllocationCallbacks, subAllocatorCallbacks: ^VulkanTexture_subAllocatorCallbacks) -> Result ---
	VulkanTexture_Destruct :: proc(this: ^VulkanTexture, device: vk.Device, pAllocator: ^vk.AllocationCallbacks) ---

	VulkanDeviceInfo_CreateEx :: proc(instance: vk.Instance, physicalDevice: vk.PhysicalDevice, device: vk.Device, queue: vk.Queue, cmdPool: vk.CommandPool, pAllocator: ^vk.AllocationCallbacks, pFunctions: ^VulkanFunctions) -> ^VulkanDeviceInfo ---
	VulkanDeviceInfo_Create :: proc(physicalDevice: vk.PhysicalDevice, device: vk.Device, queue: vk.Queue, cmdPool: vk.CommandPool, pAllocator: ^vk.AllocationCallbacks) -> ^VulkanDeviceInfo ---
	VulkanDeviceInfo_Construct :: proc(this: ^VulkanDeviceInfo, physicalDevice: vk.PhysicalDevice, device: vk.Device, queue: vk.Queue, cmdPool: vk.CommandPool, pAllocator: ^vk.AllocationCallbacks) -> Result ---
	VulkanDeviceInfo_ConstructEx :: proc(this: ^VulkanDeviceInfo, instance: vk.Instance, physicalDevice: vk.PhysicalDevice, device: vk.Device, queue: vk.Queue, cmdPool: vk.CommandPool, pAllocator: ^vk.AllocationCallbacks, pFunctions: ^VulkanFunctions) -> Result ---
	VulkanDeviceInfo_Destruct :: proc(this: ^VulkanDeviceInfo) ---
	VulkanDeviceInfo_Destroy :: proc(this: ^VulkanDeviceInfo) ---

	Texture_VkUploadEx_WithSuballocator :: proc(this: ^Texture, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture, tiling: vk.ImageTiling, usageFlags: vk.ImageUsageFlags, finalLayout: vk.ImageLayout, subAllocatorCallbacks: ^VulkanTexture_subAllocatorCallbacks) -> Result ---
	Texture_VkUploadEx :: proc(this: ^Texture, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture, tiling: vk.ImageTiling, usageFlags: vk.ImageUsageFlags, finalLayout: vk.ImageLayout) -> Result ---
	Texture_VkUpload :: proc(texture: ^Texture, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture) -> Result ---

	Texture1_VkUploadEx_WithSuballocator :: proc(this: ^Texture1, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture, tiling: vk.ImageTiling, usageFlags: vk.ImageUsageFlags, finalLayout: vk.ImageLayout, subAllocatorCallbacks: ^VulkanTexture_subAllocatorCallbacks) -> Result ---
	Texture1_VkUploadEx :: proc(this: ^Texture1, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture, tiling: vk.ImageTiling, usageFlags: vk.ImageUsageFlags, finalLayout: vk.ImageLayout) -> Result ---
	Texture1_VkUpload :: proc(texture: ^Texture1, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture) -> Result ---

	Texture2_VkUploadEx_WithSuballocator :: proc(this: ^Texture2, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture, tiling: vk.ImageTiling, usageFlags: vk.ImageUsageFlags, finalLayout: vk.ImageLayout, subAllocatorCallbacks: ^VulkanTexture_subAllocatorCallbacks) -> Result ---
	Texture2_VkUploadEx :: proc(this: ^Texture2, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture, tiling: vk.ImageTiling, usageFlags: vk.ImageUsageFlags, finalLayout: vk.ImageLayout) -> Result ---
	Texture2_VkUpload :: proc(texture: ^Texture2, vdi: ^VulkanDeviceInfo, vkTexture: ^VulkanTexture) -> Result ---

	Texture_GetVkFormat :: proc(this: ^Texture) -> vk.Format ---
	Texture1_GetVkFormat :: proc(this: ^Texture1) -> vk.Format ---
	Texture2_GetVkFormat :: proc(this: ^Texture2) -> vk.Format ---
}
