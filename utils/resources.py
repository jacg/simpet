import os
from os.path import abspath, join, dirname
from subprocess import getstatusoutput

# Ablotue paths to folders with resources used
RESOURCES = abspath(join(dirname(dirname(abspath(__file__))), 'resources'))
BIN = abspath(join(dirname(dirname(abspath(__file__))), 'include', 'format_converters'))
FRUTICAKE = abspath(join(dirname(dirname(abspath(__file__))), 'include', 'fruitcake', 'bin'))

def get_rsc(resource, type):
    """
    Returns the absolute path to the required resource needed by SimPET
    Paths defined here include routes to resources that could be used for any
    :param resource: resource to be used
    :param type: type or resource
    :return: 
    
    Type os resources can be:
    1) image
    2) exe
    
    """
    rpath = False

    ### Templates
    if type == 'image':
        if resource == 'tpm_file':
            rpath = join(RESOURCES, 'TPM.nii')
        elif resource == 'hammers':
            rpath = join(RESOURCES, 'hammers.img')
        elif resource == 'hammers_csv':
            rpath = join(RESOURCES, 'hammers.csv')
        else:
            rpath = False

    ### Conversion tools
    elif type == 'exe':
        if resource == 'nii2analyze':
            rpath = join(BIN, 'niitoanalyze')
        elif resource == 'analyze2nii':
            rpath = join(BIN, 'analyzetonii')
        else:
            rpath = False
           
    ### Fruitcake tools
    elif type == 'fruitcake':
        executable_name = {
            'overlap'               : 'overlap_fraction_stats_rois',
            'overlap_array'         : 'get_overlap_stats_rois_array',
            'change_format'         : 'cambia_formato_hdr',
            'change_values'         : 'cambia_valores_ima_hdr',
            'change_values_array'   : 'change_values_array',
            'change_interval'       : 'cambia_valores_de_un_intervalo',
            'operate_image'         : 'opera_imagen_hdr',
            'compute_roi_hemis_vol' : 'compute_roi_hemis_volume',
            'change_img_matrix'     : 'cambia_matriz_imagen_hdr',
            'erase_negs'            : 'elimina_valores_negativos_hdr',
            'erase_nans'            : 'elimina_valores_nan_hdr',
            'histo_image'           : 'histograma_ima_hdr',
            'rois_vols'             : 'compute_roi_vol_array',
            'calc_vm_voi'           : 'calcula_vm_en_roi',
            'calc_vmax_voi'         : 'calcula_vmax_en_roi',
            'clustering_spm'        : 'generate_SPM_maps',
            'conv_sino2proy'        : 'conv_sino2proy',
            'conv_proy2sino'        : 'conv_proy2sino',
            'gen_hdr'               : 'gen_hdr',
            'convolucion_hdr'       : 'convolucion_hdr',
            'corta_pega_filcol_hdr' : 'corta_pega_filcol_hdr',
        }[resource]

        status, path = getstatusoutput(f'which {executable_name}')
        if status:
            raise SimPETExcetpion(f'Failed to find fruitcake resource: {resource}')
        print(f'FOUND: {resource:23} -> {path}')
        return path

    if os.path.exists(str(rpath)):
        return rpath
    else:
        message = "Error: Resource " + str(resource) + ' of type ' + str(type) + ' not found!'
        raise TypeError(message)


# TODO: move to a more sensible place
class SimPETExcetpion(Exception):
    pass
