package ktx_odin

Word :: enum u32 {
	VENDORID             = 0,
	DESCRIPTORTYPE       = 0,
	VERSIONNUMBER        = 1,
	DESCRIPTORBLOCKSIZE  = 1,
	MODEL                = 2,
	PRIMARIES            = 2,
	TRANSFER             = 2,
	FLAGS                = 2,
	TEXELBLOCKDIMENSION0 = 3,
	TEXELBLOCKDIMENSION1 = 3,
	TEXELBLOCKDIMENSION2 = 3,
	TEXELBLOCKDIMENSION3 = 3,
	BYTESPLANE0          = 4,
	BYTESPLANE1          = 4,
	BYTESPLANE2          = 4,
	BYTESPLANE3          = 4,
	BYTESPLANE4          = 5,
	BYTESPLANE5          = 5,
	BYTESPLANE6          = 5,
	BYTESPLANE7          = 5,
	SAMPLESTART          = 6,
	SAMPLEWORDS          = 4,
}

DF_Flag :: enum u32 {
	VENDORID             = 0,
	DESCRIPTORTYPE       = 17,
	VERSIONNUMBER        = 0,
	DESCRIPTORBLOCKSIZE  = 16,
	MODEL                = 0,
	PRIMARIES            = 8,
	TRANSFER             = 16,
	FLAGS                = 24,
	TEXELBLOCKDIMENSION0 = 0,
	TEXELBLOCKDIMENSION1 = 8,
	TEXELBLOCKDIMENSION2 = 16,
	TEXELBLOCKDIMENSION3 = 24,
	BYTESPLANE0          = 0,
	BYTESPLANE1          = 8,
	BYTESPLANE2          = 16,
	BYTESPLANE3          = 24,
	BYTESPLANE4          = 0,
	BYTESPLANE5          = 8,
	BYTESPLANE6          = 16,
	BYTESPLANE7          = 24,
}

DF_Sampleword :: enum u32 {
	BITOFFSET          = 0,
	BITLENGTH          = 0,
	CHANNELID          = 0,
	QUALIFIERS         = 0,
	SAMPLEPOSITION0    = 1,
	SAMPLEPOSITION1    = 1,
	SAMPLEPOSITION2    = 1,
	SAMPLEPOSITION3    = 1,
	SAMPLEPOSITION_ALL = 1,
	SAMPLELOWER        = 2,
	SAMPLEUPPER        = 3,
}

DF_VendorID :: enum u32 {
	KHRONOS = 0,
}

DF_KHR_DescriptorType :: enum u32 {
	BASICFORMAT           = 0,
	ADDITIONAL_PLANES     = 0x6001,
	ADDITIONAL_DIMENSIONS = 0x6002,
	NEEDED_FOR_WRITE      = 0x2000,
	NEEDED_FOR_DECODE     = 0x4000,
}

DF_VersionNumber :: enum u32 {
	VERSIONNUMBER_1_0    = 0,
	VERSIONNUMBER_1_1    = 0,
	VERSIONNUMBER_1_2    = 1,
	VERSIONNUMBER_1_3    = 2,
	VERSIONNUMBER_1_4    = 2,
	VERSIONNUMBER_LATEST = VERSIONNUMBER_1_4,
}

DF_Model :: enum u32 {
	/* No interpretation of color channels defined */
	UNSPECIFIED = 0,
	/* Color primaries (red, green, blue) + alpha, depth and stencil */
	RGBSDA      = 1,
	/* Color differences (Y', Cb, Cr) + alpha, depth and stencil */
	YUVSDA      = 2,
	/* Color differences (Y', I, Q) + alpha, depth and stencil */
	YIQSDA      = 3,
	/* Perceptual color (CIE L*a*b*) + alpha, depth and stencil */
	LABSDA      = 4,
	/* Subtractive colors (cyan, magenta, yellow, black) + alpha */
	CMYKA       = 5,
	/* Non-color coordinate data (X, Y, Z, W) */
	XYZW        = 6,
	/* Hue, saturation, value, hue angle on color circle, plus alpha */
	HSVA_ANG    = 7,
	/* Hue, saturation, lightness, hue angle on color circle, plus alpha */
	HSLA_ANG    = 8,
	/* Hue, saturation, value, hue on color hexagon, plus alpha */
	HSVA_HEX    = 9,
	/* Hue, saturation, lightness, hue on color hexagon, plus alpha */
	HSLA_HEX    = 10,
	/* Lightweight approximate color difference (luma, orange, green) */
	YCGCOA      = 11,
	/* ITU BT.2020 constant luminance YcCbcCrc */
	YCCBCCRC    = 12,
	/* ITU BT.2100 constant intensity ICtCp */
	ICTCP       = 13,
	/* CIE 1931 XYZ color coordinates (X, Y, Z) */
	CIEXYZ      = 14,
	/* CIE 1931 xyY color coordinates (X, Y, Y) */
	CIEXYY      = 15,

	/* Compressed formats start at 128. */
	/* These compressed formats should generally have a single sample,
       sited at the 0,0 position of the texel block. Where multiple
       channels are used to distinguish formats, these should be cosited. */
	/* Direct3D (and S3) compressed formats */
	/* Note that premultiplied status is recorded separately */
	/* DXT1 "channels" are RGB (0), Alpha (1) */
	/* DXT1/BC1 with one channel is opaque */
	/* DXT1/BC1 with a cosited alpha sample is transparent */
	DXT1A       = 128,
	BC1A        = 128,
	/* DXT2/DXT3/BC2, with explicit 4-bit alpha */
	DXT2        = 129,
	DXT3        = 129,
	BC2         = 129,
	/* DXT4/DXT5/BC3, with interpolated alpha */
	DXT4        = 130,
	DXT5        = 130,
	BC3         = 130,
	/* ATI1n/DXT5A/BC4 - single channel interpolated 8-bit data */
	/* (The UNORM/SNORM variation is recorded in the channel data) */
	ATI1N       = 131,
	DXT5A       = 131,
	BC4         = 131,
	/* ATI2n_XY/DXN/BC5 - two channel interpolated 8-bit data */
	/* (The UNORM/SNORM variation is recorded in the channel data) */
	ATI2N_XY    = 132,
	DXN         = 132,
	BC5         = 132,
	/* BC6H - DX11 format for 16-bit float channels */
	BC6H        = 133,
	/* BC7 - DX11 format */
	BC7         = 134,
	/* Gap left for future desktop expansion */

	/* Mobile compressed formats follow */
	/* A format of ETC1 indicates that the format shall be decodable
       by an ETC1-compliant decoder and not rely on ETC2 features */
	ETC1        = 160,
	/* A format of ETC2 is permitted to use ETC2 encodings on top of
       the baseline ETC1 specification */
	/* The ETC2 format has channels "red", "green", "RGB" and "alpha",
       which should be cosited samples */
	/* Punch-through alpha can be distinguished from full alpha by
       the plane size in bytes required for the texel block */
	ETC2        = 161,
	/* Adaptive Scalable Texture Compression */
	/* ASTC HDR vs LDR is determined by the float flag in the channel */
	/* ASTC block size can be distinguished by texel block size */
	ASTC        = 162,
	/* ETC1S is a simplified subset of ETC1 */
	ETC1S       = 163,
	/* PowerVR Texture Compression */
	PVRTC       = 164,
	PVRTC2      = 165,
	UASTC       = 166,
}

DF_Model_Channels :: enum u32 {
	/* Unspecified format with nominal channel numbering */
	UNSPECIFIED_0       = 0,
	UNSPECIFIED_1       = 1,
	UNSPECIFIED_2       = 2,
	UNSPECIFIED_3       = 3,
	UNSPECIFIED_4       = 4,
	UNSPECIFIED_5       = 5,
	UNSPECIFIED_6       = 6,
	UNSPECIFIED_7       = 7,
	UNSPECIFIED_8       = 8,
	UNSPECIFIED_9       = 9,
	UNSPECIFIED_10      = 10,
	UNSPECIFIED_11      = 11,
	UNSPECIFIED_12      = 12,
	UNSPECIFIED_13      = 13,
	UNSPECIFIED_14      = 14,
	UNSPECIFIED_15      = 15,
	/* MODEL_RGBSDA - red, green, blue, stencil, depth, alpha */
	RGBSDA_RED          = 0,
	RGBSDA_R            = 0,
	RGBSDA_GREEN        = 1,
	RGBSDA_G            = 1,
	RGBSDA_BLUE         = 2,
	RGBSDA_B            = 2,
	RGBSDA_STENCIL      = 13,
	RGBSDA_S            = 13,
	RGBSDA_DEPTH        = 14,
	RGBSDA_D            = 14,
	RGBSDA_ALPHA        = 15,
	RGBSDA_A            = 15,
	/* MODEL_YUVSDA - luma, Cb, Cr, stencil, depth, alpha */
	YUVSDA_Y            = 0,
	YUVSDA_CB           = 1,
	YUVSDA_U            = 1,
	YUVSDA_CR           = 2,
	YUVSDA_V            = 2,
	YUVSDA_STENCIL      = 13,
	YUVSDA_S            = 13,
	YUVSDA_DEPTH        = 14,
	YUVSDA_D            = 14,
	YUVSDA_ALPHA        = 15,
	YUVSDA_A            = 15,
	/* MODEL_YIQSDA - luma, in-phase, quadrature, stencil, depth, alpha */
	YIQSDA_Y            = 0,
	YIQSDA_I            = 1,
	YIQSDA_Q            = 2,
	YIQSDA_STENCIL      = 13,
	YIQSDA_S            = 13,
	YIQSDA_DEPTH        = 14,
	YIQSDA_D            = 14,
	YIQSDA_ALPHA        = 15,
	YIQSDA_A            = 15,
	/* MODEL_LABSDA - CIELAB/L*a*b* luma, red-green, blue-yellow, stencil, depth, alpha */
	LABSDA_L            = 0,
	LABSDA_A            = 1,
	LABSDA_B            = 2,
	LABSDA_STENCIL      = 13,
	LABSDA_S            = 13,
	LABSDA_DEPTH        = 14,
	LABSDA_D            = 14,
	LABSDA_ALPHA        = 15,
	/* NOTE: KHR_DF_CHANNEL_LABSDA_A is not a synonym for alpha! */
	/* MODEL_CMYKA - cyan, magenta, yellow, key/blacK, alpha */
	CMYKSDA_CYAN        = 0,
	CMYKSDA_C           = 0,
	CMYKSDA_MAGENTA     = 1,
	CMYKSDA_M           = 1,
	CMYKSDA_YELLOW      = 2,
	CMYKSDA_Y           = 2,
	CMYKSDA_KEY         = 3,
	CMYKSDA_BLACK       = 3,
	CMYKSDA_K           = 3,
	CMYKSDA_ALPHA       = 15,
	CMYKSDA_A           = 15,
	/* MODEL_XYZW - coordinates x, y, z, w */
	XYZW_X              = 0,
	XYZW_Y              = 1,
	XYZW_Z              = 2,
	XYZW_W              = 3,
	/* MODEL_HSVA_ANG - value (luma), saturation, hue, alpha, angular projection, conical space */
	HSVA_ANG_VALUE      = 0,
	HSVA_ANG_V          = 0,
	HSVA_ANG_SATURATION = 1,
	HSVA_ANG_S          = 1,
	HSVA_ANG_HUE        = 2,
	HSVA_ANG_H          = 2,
	HSVA_ANG_ALPHA      = 15,
	HSVA_ANG_A          = 15,
	/* MODEL_HSLA_ANG - lightness (luma), saturation, hue, alpha, angular projection, double conical space */
	HSLA_ANG_LIGHTNESS  = 0,
	HSLA_ANG_L          = 0,
	HSLA_ANG_SATURATION = 1,
	HSLA_ANG_S          = 1,
	HSLA_ANG_HUE        = 2,
	HSLA_ANG_H          = 2,
	HSLA_ANG_ALPHA      = 15,
	HSLA_ANG_A          = 15,
	/* MODEL_HSVA_HEX - value (luma), saturation, hue, alpha, hexagonal projection, conical space */
	HSVA_HEX_VALUE      = 0,
	HSVA_HEX_V          = 0,
	HSVA_HEX_SATURATION = 1,
	HSVA_HEX_S          = 1,
	HSVA_HEX_HUE        = 2,
	HSVA_HEX_H          = 2,
	HSVA_HEX_ALPHA      = 15,
	HSVA_HEX_A          = 15,
	/* MODEL_HSLA_HEX - lightness (luma), saturation, hue, alpha, hexagonal projection, double conical space */
	HSLA_HEX_LIGHTNESS  = 0,
	HSLA_HEX_L          = 0,
	HSLA_HEX_SATURATION = 1,
	HSLA_HEX_S          = 1,
	HSLA_HEX_HUE        = 2,
	HSLA_HEX_H          = 2,
	HSLA_HEX_ALPHA      = 15,
	HSLA_HEX_A          = 15,
	/* MODEL_YCGCOA - luma, green delta, orange delta, alpha */
	YCGCOA_Y            = 0,
	YCGCOA_CG           = 1,
	YCGCOA_CO           = 2,
	YCGCOA_ALPHA        = 15,
	YCGCOA_A            = 15,
	/* MODEL_CIEXYZ - CIE 1931 X, Y, Z */
	CIEXYZ_X            = 0,
	CIEXYZ_Y            = 1,
	CIEXYZ_Z            = 2,
	/* MODEL_CIEXYY - CIE 1931 x, y, Y */
	CIEXYY_X            = 0,
	CIEXYY_YCHROMA      = 1,
	CIEXYY_YLUMA        = 2,

	/* Compressed formats */
	/* MODEL_DXT1A/MODEL_BC1A */
	DXT1A_COLOR         = 0,
	BC1A_COLOR          = 0,
	DXT1A_ALPHAPRESENT  = 1,
	DXT1A_ALPHA         = 1,
	BC1A_ALPHAPRESENT   = 1,
	BC1A_ALPHA          = 1,
	/* MODEL_DXT2/3/MODEL_BC2 */
	DXT2_COLOR          = 0,
	DXT3_COLOR          = 0,
	BC2_COLOR           = 0,
	DXT2_ALPHA          = 15,
	DXT3_ALPHA          = 15,
	BC2_ALPHA           = 15,
	/* MODEL_DXT4/5/MODEL_BC3 */
	DXT4_COLOR          = 0,
	DXT5_COLOR          = 0,
	BC3_COLOR           = 0,
	DXT4_ALPHA          = 15,
	DXT5_ALPHA          = 15,
	BC3_ALPHA           = 15,
	/* MODEL_BC4 */
	BC4_DATA            = 0,
	/* MODEL_BC5 */
	BC5_RED             = 0,
	BC5_R               = 0,
	BC5_GREEN           = 1,
	BC5_G               = 1,
	/* MODEL_BC6H */
	BC6H_COLOR          = 0,
	BC6H_DATA           = 0,
	/* MODEL_BC7 */
	BC7_DATA            = 0,
	BC7_COLOR           = 0,
	/* MODEL_ETC1 */
	ETC1_DATA           = 0,
	ETC1_COLOR          = 0,
	/* MODEL_ETC2 */
	ETC2_RED            = 0,
	ETC2_R              = 0,
	ETC2_GREEN          = 1,
	ETC2_G              = 1,
	ETC2_COLOR          = 2,
	ETC2_ALPHA          = 15,
	ETC2_A              = 15,
	/* MODEL_ASTC */
	ASTC_DATA           = 0,
	/* MODEL_ETC1S */
	ETC1S_RGB           = 0,
	ETC1S_RRR           = 3,
	ETC1S_GGG           = 4,
	ETC1S_AAA           = 15,
	/* MODEL_PVRTC */
	PVRTC_DATA          = 0,
	PVRTC_COLOR         = 0,
	/* MODEL_PVRTC2 */
	PVRTC2_DATA         = 0,
	PVRTC2_COLOR        = 0,
	/* MODEL UASTC */
	UASTC_RGB           = 0,
	UASTC_RGBA          = 3,
	UASTC_RRR           = 4,
	UASTC_RRRG          = 5,
	UASTC_RG            = 6,

	/* Common channel names shared by multiple formats */
	COMMON_LUMA         = 0,
	COMMON_L            = 0,
	COMMON_STENCIL      = 13,
	COMMON_S            = 13,
	COMMON_DEPTH        = 14,
	COMMON_D            = 14,
	COMMON_ALPHA        = 15,
	COMMON_A            = 15,
}

DF_Primaries :: enum u32 {
	UNSPECIFIED = 0,
	BT709       = 1,
	SRGB        = 1,
	BT601_EBU   = 2,
	BT601_SMPTE = 3,
	BT2020      = 4,
	BT2100      = 4,
	CIEXYZ      = 5,
	ACES        = 6,
	ACESCC      = 7,
	NTSC1953    = 8,
	PAL525      = 9,
	DISPLAYP3   = 10,
	ADOBERGB    = 11,
}

DF_Transfer :: enum u32 {
	/* No transfer function defined */
	UNSPECIFIED           = 0,
	/* Linear transfer function (value proportional to intensity) */
	LINEAR                = 1,
	/* Perceptually-linear transfer function of sRGB (~2.2); also used for scRGB */
	SRGB                  = 2,
	SRGB_EOTF             = 2,
	SCRGB                 = 2,
	SCRGB_EOTF            = 2,
	/* Perceptually-linear transfer function of ITU BT.601, BT.709 and BT.2020 (~1/.45) */
	ITU                   = 3,
	ITU_OETF              = 3,
	BT601                 = 3,
	BT601_OETF            = 3,
	BT709                 = 3,
	BT709_OETF            = 3,
	BT2020                = 3,
	BT2020_OETF           = 3,
	/* SMTPE170M (digital NTSC) defines an alias for the ITU transfer function (~1/.45) and a linear OOTF */
	SMTPE170M             = 3,
	SMTPE170M_OETF        = 3,
	SMTPE170M_EOTF        = 3,
	/* Perceptually-linear gamma function of original NTSC (simple 2.2 gamma) */
	NTSC                  = 4,
	NTSC_EOTF             = 4,
	/* Sony S-log used by Sony video cameras */
	SLOG                  = 5,
	SLOG_OETF             = 5,
	/* Sony S-log 2 used by Sony video cameras */
	SLOG2                 = 6,
	SLOG2_OETF            = 6,
	/* ITU BT.1886 EOTF */
	BT1886                = 7,
	BT1886_EOTF           = 7,
	/* ITU BT.2100 HLG OETF (typical scene-referred content), linear light normalized 0..1 */
	HLG_OETF              = 8,
	/* ITU BT.2100 HLG EOTF (nominal HDR display of HLG content), linear light normalized 0..1 */
	HLG_EOTF              = 9,
	/* ITU BT.2100 PQ EOTF (typical HDR display-referred PQ content) */
	PQ_EOTF               = 10,
	/* ITU BT.2100 PQ OETF (nominal scene described by PQ HDR content) */
	PQ_OETF               = 11,
	/* DCI P3 transfer function */
	DCIP3                 = 12,
	DCIP3_EOTF            = 12,
	/* Legacy PAL OETF */
	PAL_OETF              = 13,
	/* Legacy PAL 625-line EOTF */
	PAL625_EOTF           = 14,
	/* Legacy ST240 transfer function */
	ST240                 = 15,
	ST240_OETF            = 15,
	ST240_EOTF            = 15,
	/* ACEScc transfer function */
	ACESCC                = 16,
	ACESCC_OETF           = 16,
	/* ACEScct transfer function */
	ACESCCT               = 17,
	ACESCCT_OETF          = 17,
	/* Adobe RGB (1998) transfer function */
	ADOBERGB              = 18,
	ADOBERGB_EOTF         = 18,
	/* Legacy ITU BT.2100 HLG OETF (typical scene-referred content), linear light normalized 0..12 */
	HLG_UNNORMALIZED_OETF = 19,
}

DF_Flags :: enum u32 {
	STRAIGHT      = 0,
	PREMULTIPLIED = 1,
}

DF_Sample_Datatype_Qualifiers :: enum u32 {
	LINEAR   = 4,
	EXPONENT = 5,
	SIGNED   = 6,
	FLOAT    = 7,
}
