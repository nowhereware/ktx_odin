package ktx_odin

import "core:c/libc"

@(export)
foreign import lib "ktx.lib"

ANIMDATA_KEY :: "KTXanimData"
ORIENTATION_KEY :: "KTXorientation"
SWIZZLE_KEY :: "KTXswizzle"
WRITER_KEY :: "KTXwriter"
WRITER_SCPARAMS_KEY :: "KTXwriterScParams"
ORIENTATION1_FMT :: "S=%c"
ORIENTATION2_FMT :: "S=%c,T=%c"
ORIENTATION3_FMT :: "S=%c,T=%c,R=%c"

Result :: enum {
	SUCCESS = 0,
	FILE_DATA_ERROR,
	FILE_ISPIPE,
	FILE_OPEN_FAILED,
	FILE_OVERFLOW,
	FILE_READ_ERROR,
	FILE_SEEK_ERROR,
	FILE_UNEXPECTED_EOF,
	FILE_WRITE_ERROR,
	GL_ERROR,
	INVALID_OPERATION,
	INVALID_VALUE,
	NOT_FOUND,
	OUT_OF_MEMORY,
	TRANSCODE_FAILED,
	UNKNOWN_FILE_FORMAT,
	UNSUPPORTED_TEXTURE_TYPE,
	UNSUPPORTED_FEATURE,
	LIBRARY_NOT_LINKED,
	DECOMPRESS_LENGTH_ERROR,
	DECOMPRESS_CHECKSUM_ERROR,
}

KVListEntry :: struct {}
HashList :: ^KVListEntry
HashListEntry :: KVListEntry

OrientationX :: enum i32 {
	LEFT  = 'l',
	RIGHT = 'r',
}

OrientationY :: enum i32 {
	UP   = 'u',
	DOWN = 'd',
}

OrientationZ :: enum i32 {
	IN  = 'i',
	OUT = 'o',
}

Orientation :: struct {
	x: OrientationX,
	y: OrientationY,
	z: OrientationZ,
}

class_id :: enum {
	Texture1_c = 1,
	Texture2_c = 2,
}

ITERCB :: #type proc "system" (
	mipLevel: i32,
	face: i32,
	width: i32,
	height: i32,
	depth: i32,
	faceLodSize: u64,
	pixels: rawptr,
	userdata: rawptr,
) -> Result

TEXDESTROY :: #type proc "system" (this: ^Texture)
TEXGETIMAGEOFFSET :: #type proc "system" (
	this: ^Texture,
	level: u32,
	layer: u32,
	faceSlice: u32,
	pOffset: ^uint,
) -> Result
TEXGETDATASIZEUNCOMPRESSED :: #type proc "system" (this: ^Texture) -> uint
TEXGETIMAGESIZE :: #type proc "system" (this: ^Texture, level: u32) -> uint
TEXGETLEVELSIZE :: #type proc "system" (this: ^Texture, level: u32) -> uint
TEXITERATELEVELS :: #type proc "system" (this: ^Texture, iterCb: ITERCB, userdata: rawptr) -> Result
TEXITERATELOADLEVELFACES :: #type proc "system" (this: ^Texture, iterCb: ITERCB, userdata: rawptr) -> Result
TEXLOADIMAGEDATA :: #type proc "system" (this: ^Texture, pBuffer: [^]u8, bufSize: uint) -> Result
TEXNEEDSTRANSCODING :: #type proc "system" (this: ^Texture) -> bool
TEXSETIMAGEFROMMEMORY :: #type proc "system" (
	this: ^Texture,
	level: u32,
	layer: u32,
	faceSlice: u32,
	src: [^]u8,
	srcSize: uint,
) -> Result
TEXSETIMAGEFROMSTDIOSTREAM :: #type proc "system" (
	this: ^Texture,
	level: u32,
	layer: u32,
	faceSlice: u32,
	src: ^libc.FILE,
	srcSize: uint,
) -> Result
TEXWRITETOSTDIOSTREAM :: #type proc "system" (this: ^Texture, dstsstr: ^libc.FILE) -> Result
TEXWRITETONAMEDFILE :: #type proc "system" (this: ^Texture, dstname: cstring) -> Result
TEXWRITETOMEMORY :: #type proc "system" (this: ^Texture, bytes: ^[^]u8, size: ^uint) -> Result
TEXWRITETOSTREAM :: #type proc "system" (this: ^Texture, dststr: ^Stream) -> Result

Texture_vtbl :: struct {
	Destroy:                 TEXDESTROY,
	GetImageOffset:          TEXGETIMAGEOFFSET,
	GetDataSizeUncompressed: TEXGETDATASIZEUNCOMPRESSED,
	GetImageSize:            TEXGETIMAGESIZE,
	GetLevelSize:            TEXGETLEVELSIZE,
	IterateLevels:           TEXITERATELEVELS,
	IterateLoadLevelFaces:   TEXITERATELOADLEVELFACES,
	NeedsTranscoding:        TEXNEEDSTRANSCODING,
	LoadImageData:           TEXLOADIMAGEDATA,
	SetImageFromMemory:      TEXSETIMAGEFROMMEMORY,
	SetImageFromStdioStream: TEXSETIMAGEFROMSTDIOSTREAM,
	WriteToStdioStream:      TEXWRITETOSTDIOSTREAM,
	WriteToNamedFile:        TEXWRITETONAMEDFILE,
	WriteToMemory:           TEXWRITETOMEMORY,
	WriteToStream:           TEXWRITETOSTREAM,
}

Texture :: struct {
	classId:         class_id,
	using vtbl:      ^Texture_vtbl,
	vvtbl:           rawptr,
	_protected:      rawptr,
	isArray:         bool,
	isCubemap:       bool,
	isCompressed:    bool,
	generateMipmaps: bool,
	baseWidth:       u32,
	baseHeight:      u32,
	baseDepth:       u32,
	numDimensions:   u32,
	numLevels:       u32,
	numLayers:       u32,
	numFaces:        u32,
	orientation:     Orientation,
	kvDataHead:      HashList,
	kvDataLen:       u32,
	kvData:          [^]u8,
	dataSize:        uint,
	pData:           [^]u8,
}

Texture1 :: struct {
	using texture:        Texture,
	glFormat:             u32,
	glInternalformat:     u32,
	glBaseInternalformat: u32,
	glType:               u32,
	_private:             rawptr,
}

SupercmpScheme :: enum i32 {
	NONE     = 0,
	BASIS_LZ = 1,
	ZSTD     = 2,
	ZLIB     = 3,
}

Texture2 :: struct {
	using texture:          Texture,
	vkFormat:               u32,
	pDfd:                   ^u32,
	supercompressionScheme: SupercmpScheme,
	isVideo:                bool,
	duration:               u32,
	timescale:              u32,
	loopcount:              u32,
	_private:               rawptr,
}

TextureCreateInfo :: struct {
	glInternalFormat: u32,
	vkFormat:         u32,
	pDfd:             ^u32,
	baseWidth:        u32,
	baseHeight:       u32,
	baseDepth:        u32,
	numDimensions:    u32,
	numLevels:        u32,
	numLayers:        u32,
	numFaces:         u32,
	isArray:          bool,
	generateMipmaps:  bool,
}

TextureCreateStorage :: enum i32 {
	NO_STORAGE    = 0,
	ALLOC_STORAGE = 1,
}

TextureCreateFlag :: enum u32 {
	LOAD_IMAGE_DATA   = 0,
	RAW_KVDATA        = 1,
	SKIP_KVDATA       = 2,
	CHECK_GLTF_BASISU = 3,
}
TextureCreateFlags :: bit_set[TextureCreateFlag;u32]

Mem :: struct {}

StreamType :: enum {
	File   = 1,
	Memory = 2,
	Custom = 3,
}

when ODIN_OS == .Windows {
	off_t :: u64
} else {
	// Most platforms define off_t as a signed 64-bit integer.
	off_t :: i64
}

Stream_read :: #type proc "system" (str: ^Stream, dst: rawptr, count: uint) -> Result
Stream_skip :: #type proc "system" (str: ^Stream, count: uint) -> Result
Stream_write :: #type proc "system" (str: ^Stream, src: rawptr, size: uint, count: uint) -> Result
Stream_getpos :: #type proc "system" (str: ^Stream, offset: ^u64) -> Result
Stream_setpos :: #type proc "system" (str: ^Stream, offset: off_t) -> Result
Stream_getsize :: #type proc "system" (str: ^Stream, size: ^uint) -> Result
Stream_destruct :: #type proc "system" (str: ^Stream)

Stream :: struct {
	read:            Stream_read,
	skip:            Stream_skip,
	write:           Stream_write,
	getpos:          Stream_getpos,
	setpos:          Stream_setpos,
	getsize:         Stream_getsize,
	destruct:        Stream_destruct,
	type:            StreamType,
	data:            struct #raw_union {
		file:       ^libc.FILE,
		mem:        ^Mem,
		custom_ptr: struct {
			address:          rawptr,
			allocatorAddress: rawptr,
			size:             uint,
		},
	},
	readpos:         off_t,
	closeOnDestruct: bool,
}

VOIDFUNCTION :: #type proc "system" ()
GLGETPROCADDRESS :: #type proc "system" (_proc: cstring) -> VOIDFUNCTION

// Default ({}) is FASTEST. SLOWER = {.FASTER, .DEFAULT}
UASTC_Flag :: enum u32 {
	FASTER                            = 0,
	DEFAULT                           = 1,
	VERYSLOW                          = 2,
	FAVOR_UASTC_ERROR                 = 3,
	FAVOR_BC7_ERROR                   = 4,
	ETC1_FASTER_HINTS                 = 6,
	ETC1_FASTEST_HINTS                = 7,
	// Not documented in BasisU code.
	_ETC1_DISABLE_FLIP_AND_INDIVIDUAL = 8,
}
UASTC_Flags :: bit_set[UASTC_Flag;u32]

ASTC_Quality_Level :: enum u32 {
	FASTEST    = 0,
	FAST       = 10,
	MEDIUM     = 60,
	THOROUGH   = 98,
	EXHAUSTIVE = 100,
}

ASTC_Block_Dimension :: enum u32 {
	_4x4, //: 8.00 bpp
	_5x4, //: 6.40 bpp
	_5x5, //: 5.12 bpp
	_6x5, //: 4.27 bpp
	_6x6, //: 3.56 bpp
	_8x5, //: 3.20 bpp
	_8x6, //: 2.67 bpp
	_10x5, //: 2.56 bpp
	_10x6, //: 2.13 bpp
	_8x8, //: 2.00 bpp
	_10x8, //: 1.60 bpp
	_10x10, //: 1.28 bpp
	_12x10, //: 1.07 bpp
	_12x12, //: 0.89 bpp
	// 3D formats
	_3x3x3, //: 4.74 bpp
	_4x3x3, //: 3.56 bpp
	_4x4x3, //: 2.67 bpp
	_4x4x4, //: 2.00 bpp
	_5x4x4, //: 1.60 bpp
	_5x5x4, //: 1.28 bpp
	_5x5x5, //: 1.02 bpp
	_6x5x5, //: 0.85 bpp
	_6x6x5, //: 0.71 bpp
	_6x6x6, //: 0.59 bpp
}

ASTC_Encoder_Mode :: enum u32 {
	DEFAULT,
	LDR,
	HDR,
}

AstcParams :: struct {
	structSize:     u32,
	verbose:        bool,
	threadCount:    u32,
	blockDimension: ASTC_Block_Dimension,
	mode:           ASTC_Encoder_Mode,
	qualityLevel:   ASTC_Quality_Level,
	normalMap:      bool,
	perceptual:     bool,
	inputSwizzle:   [4]u8,
}

BasisParams :: struct {
	structSize:                       u32,
	uastc:                            bool,
	verbose:                          bool,
	noSSE:                            bool,
	threadCount:                      u32,
	// Range: [0, 6]
	compressionLevel:                 u32,
	// Range: [1, 255]
	qualityLevel:                     u32,
	// Range: [1, 16128], Default is 0 (unset).
	maxEndpoints:                     u32,
	endpointRDOThreshold:             f32,
	// Range: [1, 16128], Default is 0 (unset).
	maxSelectors:                     u32,
	selectorRDOThreshold:             f32,
	inputSwizzle:                     [4]u8,
	normalMap:                        bool,
	separateRGToRGB_A:                bool,
	preSwizzle:                       bool,
	noEndpointRDO:                    bool,
	noSelectorRDO:                    bool,
	uastcFlags:                       UASTC_Flags,
	uastcRDO:                         bool,
	uastcRDOQualityScalar:            f32,
	uastcRDODictSize:                 u32,
	uastcRDOMaxSmoothBlockErrorScale: f32,
	uastcRDOMaxSmoothBlockStdDev:     f32,
	uastcRDODontFavorSimplerModes:    bool,
	uastcRDONoMultithreading:         bool,
}

Transcode_FMT :: enum i32 {
	// ETC1-2
	ETC1_RGB      = 0,
	/*!< Opaque only. Returns RGB or alpha data, if
                 KTX_TF_TRANSCODE_ALPHA_DATA_TO_OPAQUE_FORMATS flag is
                 specified. */
	ETC2_RGBA     = 1,
	/*!< Opaque+alpha. EAC_A8 block followed by an ETC1 block. The
                 alpha channel will be opaque for textures without an alpha
                 channel. */

	// BC1-5, BC7 (desktop, some mobile devices)
	BC1_RGB       = 2,
	/*!< Opaque only, no punchthrough alpha support yet.  Returns RGB
                 or alpha data, if KTX_TF_TRANSCODE_ALPHA_DATA_TO_OPAQUE_FORMATS
                 flag is specified. */
	BC3_RGBA      = 3,
	/*!< Opaque+alpha. BC4 block with alpha followed by a BC1 block. The
                 alpha channel will be opaque for textures without an alpha
                 channel. */
	BC4_R         = 4,
	/*!< One BC4 block. R = opaque.g or alpha.g, if
                 KTX_TF_TRANSCODE_ALPHA_DATA_TO_OPAQUE_FORMATS flag is
                 specified. */
	BC5_RG        = 5,
	/*!< Two BC4 blocks, R=opaque.g and G=alpha.g The texture should
                 have an alpha channel (if not G will be all 255's. For tangent
                 space normal maps. */
	BC7_RGBA      = 6,
	/*!< RGB or RGBA mode 5 for ETC1S, modes 1, 2, 3, 4, 5, 6, 7 for
                 UASTC. */

	// PVRTC1 4bpp (mobile, PowerVR devices)
	PVRTC1_4_RGB  = 8,
	/*!< Opaque only. Returns RGB or alpha data, if
                 KTX_TF_TRANSCODE_ALPHA_DATA_TO_OPAQUE_FORMATS flag is
                 specified. */
	PVRTC1_4_RGBA = 9,
	/*!< Opaque+alpha. Most useful for simple opacity maps. If the
                 texture doesn't have an alpha channel KTX_TTF_PVRTC1_4_RGB
                 will be used instead. Lowest quality of any supported
                 texture format. */

	// ASTC (mobile, Intel devices, hopefully all desktop GPU's one day)
	ASTC_4x4_RGBA = 10,
	/*!< Opaque+alpha, ASTC 4x4. The alpha channel will be opaque for
                 textures without an alpha channel.  The transcoder uses
                 RGB/RGBA/L/LA modes, void extent, and up to two ([0,47] and
                 [0,255]) endpoint precisions. */

	// ATC and FXT1 formats are not supported by KTX2 as there
	// are no equivalent VkFormats.
	PVRTC2_4_RGB  = 18,
	/*!< Opaque-only. Almost BC1 quality, much faster to transcode
                 and supports arbitrary texture dimensions (unlike
                 PVRTC1 RGB). */
	PVRTC2_4_RGBA = 19,
	/*!< Opaque+alpha. Slower to transcode than cTFPVRTC2_4_RGB.
                 Premultiplied alpha is highly recommended, otherwise the
                 color channel can leak into the alpha channel on transparent
                 blocks. */
	ETC2_EAC_R11  = 20,
	/*!< R only (ETC2 EAC R11 unsigned). R = opaque.g or alpha.g, if
                 KTX_TF_TRANSCODE_ALPHA_DATA_TO_OPAQUE_FORMATS flag is
                 specified. */
	ETC2_EAC_RG11 = 21,
	/*!< RG only (ETC2 EAC RG11 unsigned), R=opaque.g, G=alpha.g. The
                 texture should have an alpha channel (if not G will be all
                 255's. For tangent space normal maps. */

	// Uncompressed (raw pixel) formats
	RGBA32        = 13,
	/*!< 32bpp RGBA image stored in raster (not block) order in
                 memory, R is first byte, A is last byte. */
	RGB565        = 14,
	/*!< 16bpp RGB image stored in raster (not block) order in memory,
                 R at bit position 11. */
	BGR565        = 15,
	/*!< 16bpp RGB image stored in raster (not block) order in memory,
                 R at bit position 0. */
	RGBA4444      = 16,
	/*!< 16bpp RGBA image stored in raster (not block) order in memory,
                 R at bit position 12, A at bit position 0. */

	// Values for automatic selection of RGB or RGBA depending if alpha
	// present.
	ETC           = 22,
	/*!< Automatically selects @c KTX_TTF_ETC1_RGB or
                 @c KTX_TTF_ETC2_RGBA according to presence of alpha. */
	BC1_OR_3      = 23,
	/*!< Automatically selects @c KTX_TTF_BC1_RGB or
                 @c KTX_TTF_BC3_RGBA according to presence of alpha. */
}

Transcode_Flag :: enum u32 {
	PVRTC_DECODE_TO_NEXT_POW2              = 1,
	TRANSCODE_ALPHA_DATA_TO_OPAQUE_FORMATS = 2,
	HIGH_QUALITY                           = 6,
}
Transcode_Flags :: bit_set[Transcode_Flag;u32]

@(default_calling_convention = "system", link_prefix = "ktx")
foreign lib {
	LoadOpenGL :: proc(pfnGLGetProcAddress: GLGETPROCADDRESS) -> Result ---

	Texture_CreateFromStdioStream :: proc(stdioStream: ^libc.FILE, createFlags: TextureCreateFlags, newTex: ^^Texture) -> Result ---
	Texture_CreateFromNamedFile :: proc(filename: cstring, createFlags: TextureCreateFlags, newtex: ^^Texture) -> Result ---
	Texture_CreateFromMemory :: proc(bytes: [^]u8, size: uint, createFlags: TextureCreateFlags, newTex: ^^Texture) -> Result ---
	Texture_CreateFromStream :: proc(stream: ^Stream, createFlags: TextureCreateFlags, newTex: ^^Texture) -> Result ---
	Texture_GetData :: proc(this: ^Texture) -> ^u8 ---
	Texture_GetRowPitch :: proc(this: ^Texture, level: u32) -> u32 ---
	Texture_GetElementSize :: proc(this: ^Texture) -> u32 ---
	Texture_GetDataSize :: proc(this: ^Texture) -> uint ---
	Texture_GLUpload :: proc(this: ^Texture, pTexture: ^u32, pTarget: ^u32, pGlerror: ^u32) -> Result ---
	Texture_IterateLevelFaces :: proc(this: ^Texture, iterCb: ITERCB, userdata: rawptr) -> Result ---

	Texture1_Create :: proc(#by_ptr createInfo: TextureCreateInfo, storageAllocation: TextureCreateStorage, newTex: ^^Texture1) -> Result ---
	Texture1_CreateFromStdioStream :: proc(stdioStream: ^libc.FILE, createFlags: TextureCreateFlags, newTex: ^^Texture1) -> Result ---
	Texture1_CreateFromNamedFile :: proc(filename: cstring, createFlags: TextureCreateFlags, newTex: ^^Texture1) -> Result ---
	Texture1_CreateFromMemory :: proc(bytes: [^]u8, size: uint, createFlags: TextureCreateFlags, newTex: ^^Texture1) -> Result ---
	Texture1_CreateFromStream :: proc(stream: ^Stream, createFlags: TextureCreateFlags, newTex: ^^Texture1) -> Result ---
	Texture1_Destroy :: proc(this: ^Texture1) ---
	Texture1_NeedsTranscoding :: proc(this: ^Texture1) -> bool ---
	Texture1_LoadImageData :: proc(this: ^Texture1, pBuffer: [^]u8, bufSize: uint) -> Result ---
	Texture1_WriteToStdioStream :: proc(this: ^Texture1, dstsstr: ^libc.FILE) -> Result ---
	Texture1_WriteToNamedFile :: proc(this: ^Texture1, dstname: cstring) -> Result ---
	Texture1_WriteToMemory :: proc(this: ^Texture1, bytes: ^[^]u8, size: ^uint) -> Result ---
	Texture1_WriteToStream :: proc(this: ^Texture1, dststr: ^Stream) -> Result ---
	Texture1_WriteKTX2ToStdioStream :: proc(this: ^Texture1, dstsstr: ^libc.FILE) -> Result ---
	Texture1_WriteKTX2ToNamedFile :: proc(this: ^Texture1, dstname: cstring) -> Result ---
	Texture1_WriteKTX2ToMemory :: proc(this: ^Texture1, bytes: ^[^]u8, size: ^uint) -> Result ---
	Texture1_WriteKTX2ToStream :: proc(this: ^Texture1, dststr: ^Stream) -> Result ---

	Texture2_Create :: proc(#by_ptr createInfo: TextureCreateInfo, storageAllocation: TextureCreateStorage, newTex: ^^Texture2) -> Result ---
	Texture2_CreateCopy :: proc(orig: ^Texture2, newTex: ^^Texture2) -> Result ---
	Texture2_CreateFromStdioStream :: proc(stdioStream: ^libc.FILE, createFlags: TextureCreateFlags, newTex: ^^Texture2) -> Result ---
	Texture2_CreateFromNamedFile :: proc(filename: cstring, createFlags: TextureCreateFlags, newTex: ^^Texture2) -> Result ---
	Texture2_CreateFromMemory :: proc(bytes: [^]u8, size: uint, createFlags: TextureCreateFlags, newTex: ^^Texture2) -> Result ---
	Texture2_CreateFromStream :: proc(stream: ^Stream, createFlags: TextureCreateFlags, newTex: ^^Texture2) -> Result ---
	Texture2_Destroy :: proc(this: ^Texture2) ---
	Texture2_CompressBasis :: proc(this: ^Texture2, quality: u32) -> Result ---
	Texture2_DeflateZstd :: proc(this: ^Texture2, level: u32) -> Result ---
	Texture2_DeflateZLIB :: proc(this: ^Texture2, level: u32) -> Result ---
	Texture2_GetComponentInfo :: proc(this: ^Texture2, numComponents: ^u32, componentByteLength: ^u32) ---
	Texture2_GetImageOffset :: proc(this: ^Texture2, level: u32, layer: u32, faceSlice: u32, pOffset: ^uint) -> Result ---
	Texture2_GetNumComponents :: proc(this: ^Texture2) -> u32 ---
	Texture2_GetTransferFunction_e :: proc(this: ^Texture2) -> DF_Transfer ---
	Texture2_GetOETF_e :: proc(this: ^Texture2) -> DF_Transfer ---
	Texture2_GetOETF :: proc(this: ^Texture2) -> u32 ---
	Texture2_GetColorModel_e :: proc(this: ^Texture2) -> DF_Model ---
	Texture2_GetPremultipliedAlpha :: proc(this: ^Texture2) -> bool ---
	Texture2_GetPrimaries_e :: proc(this: ^Texture2) -> DF_Primaries ---
	Texture2_NeedsTranscoding :: proc(this: ^Texture2) -> bool ---
	Texture2_SetTransferFunction :: proc(this: ^Texture2, tf: DF_Transfer) -> Result ---
	Texture2_SetOETF :: proc(this: ^Texture2, oetf: DF_Transfer) -> Result ---
	Texture2_SetPrimaries :: proc(this: ^Texture2, primaries: DF_Primaries) -> Result ---
	Texture2_LoadImageData :: proc(this: ^Texture2, pBuffer: [^]u8, bufSize: uint) -> Result ---
	Texture2_LoadDeflatedImageData :: proc(this: ^Texture2, pBuffer: [^]u8, bufSize: uint) -> Result ---
	Texture2_WriteToStdioStream :: proc(this: ^Texture2, dstsstr: ^libc.FILE) -> Result ---
	Texture2_WriteToNamedFile :: proc(this: ^Texture2, dstname: cstring) -> Result ---
	Texture2_WriteToMemory :: proc(this: ^Texture2, bytes: ^[^]u8, size: ^uint) -> Result ---
	Texture2_WriteToStream :: proc(this: ^Texture2, dststr: ^Stream) -> Result ---
	Texture2_CompressAstcEx :: proc(this: ^Texture2, params: ^AstcParams) -> Result ---
	Texture2_CompressAstc :: proc(this: ^Texture2, quality: u32) -> Result ---
	Texture2_DecodeAstc :: proc(this: ^Texture2) -> Result ---
	Texture2_CompressBasisEx :: proc(this: ^Texture2, params: ^BasisParams) -> Result ---
	Texture2_TranscodeBasis :: proc(this: ^Texture2, fmt: Transcode_FMT, flags: Transcode_Flags) -> Result ---
	ErrorString :: proc(error: Result) -> cstring ---
	SupercompressionSchemeString :: proc(scheme: SupercmpScheme) -> cstring ---
	TranscodeFormatString :: proc(format: Transcode_FMT) -> cstring ---
	HashList_Create :: proc(ppHl: ^^HashList) -> Result ---
	HashList_CreateCopy :: proc(ppHl: ^^HashList, orig: HashList) -> Result ---
	HashList_Construct :: proc(pHl: ^HashList) ---
	HashList_ConstructCopy :: proc(pHl: ^HashList, orig: HashList) ---
	HashList_Destroy :: proc(head: ^HashList) ---
	HashList_Destruct :: proc(head: ^HashList) ---

	HashList_AddKVPair :: proc(pHead: ^HashList, key: cstring) -> Result ---
	HashList_DeleteEntry :: proc(pHead: ^HashList, pEntry: ^HashListEntry) -> Result ---
	HashList_DeleteKVPair :: proc(pHead: ^HashList, key: cstring) -> Result ---
	HashList_FindEntry :: proc(pHead: ^HashList, key: cstring, ppEntry: ^^HashListEntry) -> Result ---
	HashList_FindValue :: proc(pHead: ^HashList, key: cstring, pValueLen: ^u32, pValue: ^rawptr) -> Result ---
	HashList_Next :: proc(entry: ^HashListEntry) -> ^HashListEntry ---
	HashList_Sort :: proc(pHead: ^HashList) -> Result ---
	HashList_Serialize :: proc(pHead: ^HashList, kvdLen: ^u32, kvd: ^[^]u8) -> Result ---
	HashList_Deserialize :: proc(pHead: ^HashList, kvdLen: u32, kvd: rawptr) -> Result ---
	HashListEntry_GetKey :: proc(this: ^HashListEntry, pKeyLen: ^u32, ppKey: ^[^]u8) -> Result ---
	HashListEntry_GetValue :: proc(this: ^HashListEntry, pValueLen: ^u32, ppValue: ^rawptr) -> Result ---

	PrintInfoForStdioStream :: proc(stdioStream: ^libc.FILE) -> Result ---
	PrintInfoForNamedFile :: proc(filename: cstring) -> Result ---
	PrintInfoForMemory :: proc(bytes: [^]u8, size: uint) -> Result ---

	PrintKTX1InfoTextForStream :: proc(stream: ^Stream) -> Result ---

	PrintKTX2InfoTextForMemory :: proc(bytes: [^]u8, size: uint) -> Result ---
	PrintKTX2InfoTextForNamedFile :: proc(filename: cstring) -> Result ---
	PrintKTX2InfoTextForStdioStream :: proc(stdioStream: ^libc.FILE) -> Result ---
	PrintKTX2InfoTextForStream :: proc(stream: ^Stream) -> Result ---
	PrintKTX2InfoJSONForMemory :: proc(bytes: [^]u8, size: uint, base_indent: u32, indent_width: u32, minified: bool) -> Result ---
	PrintKTX2InfoJSONForNamedFile :: proc(filename: cstring, base_indent: u32, indent_width: u32, minified: bool) -> Result ---
	PrintKTX2InfoJSONForStdioStream :: proc(stdioStream: ^libc.FILE, base_indent: u32, indent_width: u32, minified: bool) -> Result ---
	PrintKTX2InfoJSONForStream :: proc(stream: ^Stream, base_indent: u32, indent_width: u32, minified: bool) -> Result ---
}
