//
//  ContentView.swift
//  Project-13-Instafilter
//
//  Created by Luca Capriati on 2022/09/13.
//
//  Challanges:
//  Project 13 - Challange 1: Try making the Save button disabled if there is no image in the image view.
//  Project 13 - Challange 2: Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
//  Project 13 - Challange 3: Explore the range of available Core Image filters, and add any three of your choosing to the app.

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    //  Project 13 - Challange 2:
    @State private var filterRadius = 5.0
    @State private var filterScale = 5.0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    @State private var processedImage: UIImage?
    
    @State private var showingSaveError = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                //  Project 13 - Challange 2:
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius, in: 0...200)
                            .onChange(of: filterRadius) { _ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                //  Project 13 - Challange 2:
                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale, in: 0...10)
                            .onChange(of: filterScale) { _ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        //  Project 13 - Challange 1:
                        .disabled(inputImage == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    Button("Bloom") { setFilter(CIFilter.bloom())}
                    Button("Crystallize") { setFilter(CIFilter.crystallize())}
                    Button("Edges") { setFilter(CIFilter.edges())}
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur())}
                    Button("Noir") { setFilter(CIFilter.photoEffectNoir())}
                    Button("Pixellate") { setFilter(CIFilter.pixellate())}
                    Button("Pointillize") { setFilter(CIFilter.pointillize())}
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone())}
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask())}
                    Button("Vignette") { setFilter(CIFilter.vignette())}
                }
                
                Group {
                    Button("Cancel", role: .cancel) { }
                }
            }
            .alert("Failure", isPresented: $showingSaveError) {
                Button("OK") { }
            } message: {
                Text("Sorry, there was an error saving your image - please check that you have allowed permission for this app to save photos.")
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success")
        }
        imageSaver.errorHandler = {
            print("Failure! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        //  Project 13 - Challange 2:
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        //  Project 13 - Challange 2:
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
