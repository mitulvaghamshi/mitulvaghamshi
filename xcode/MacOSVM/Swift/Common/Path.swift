/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Constants that point to the various file URLs that the sample code uses.
*/

import Foundation

let vmBundlePath =
    NSHomeDirectory() + "/Developer/vscode/backup/bundle/MacOSVM.bundle/"

let vmBundleURL = URL(fileURLWithPath: vmBundlePath)

let auxiliaryStorageURL = vmBundleURL.appendingPathComponent("AuxiliaryStorage")

let diskImageURL = vmBundleURL.appendingPathComponent("Disk.img")

let hardwareModelURL = vmBundleURL.appendingPathComponent("HardwareModel")

let machineIdentifierURL = vmBundleURL.appendingPathComponent(
    "MachineIdentifier"
)

let restoreImageURL = vmBundleURL.appendingPathComponent("RestoreImage.ipsw")

let saveFileURL = vmBundleURL.appendingPathComponent("SaveFile.vzvmsave")
