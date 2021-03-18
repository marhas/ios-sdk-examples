import Mapbox

@objc(DefaultStylesExample_Swift)

class DefaultStylesExample_Swift: UIViewController {

    var mapView: MGLMapView!
    let locationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.outdoorsStyleURL)
        mapView.delegate = self
        // Tint the ℹ️ button and the user location annotation.
        mapView.tintColor = .darkGray

        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Set the map’s center coordinate and zoom level.
        centerMap()
        view.addSubview(mapView)

        let clearCacheButton = UIButton()
        clearCacheButton.translatesAutoresizingMaskIntoConstraints = false
        clearCacheButton.setTitle("Clear cache", for: .normal)
        clearCacheButton.setTitleColor(.blue, for: .normal)
        clearCacheButton.addTarget(self, action: #selector(clearCache), for: .touchUpInside)
        view.addSubview(clearCacheButton)
        clearCacheButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20).isActive = true
        clearCacheButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 20).isActive = true

        let invalidateCacheButton = UIButton()
        invalidateCacheButton.translatesAutoresizingMaskIntoConstraints = false
        invalidateCacheButton.setTitle("Invalidate cache", for: .normal)
        invalidateCacheButton.setTitleColor(.blue, for: .normal)
        invalidateCacheButton.addTarget(self, action: #selector(invalidateCache), for: .touchUpInside)
        view.addSubview(invalidateCacheButton)
        invalidateCacheButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        invalidateCacheButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        let centerMapButton = UIButton()
        centerMapButton.translatesAutoresizingMaskIntoConstraints = false
        centerMapButton.setTitle("⌖", for: .normal)
        centerMapButton.setTitleColor(.blue, for: .normal)
        centerMapButton.addTarget(self, action: #selector(centerMap), for: .touchUpInside)
        view.addSubview(centerMapButton)
        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        centerMapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20).isActive = true

        let moveMapFarAwayButton = UIButton()
        moveMapFarAwayButton.translatesAutoresizingMaskIntoConstraints = false
        moveMapFarAwayButton.setTitle("⇧", for: .normal)
        moveMapFarAwayButton.setTitleColor(.blue, for: .normal)
        moveMapFarAwayButton.addTarget(self, action: #selector(setMapCenterOnSomeFarAwayLocation), for: .touchUpInside)
        view.addSubview(moveMapFarAwayButton)
        moveMapFarAwayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        moveMapFarAwayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true

        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        updateLocationLabel(mapView: mapView)
    }

    @objc
    private func clearCache() {
        MGLOfflineStorage.shared.clearAmbientCache { error in
            if let error = error {
                print("Error clearing cache: \(error)")
            } else {
                print("Cache cleared")
            }
        }
    }

    @objc
    private func invalidateCache() {
        MGLOfflineStorage.shared.invalidateAmbientCache { error in
            if let error = error {
                print("Error invalidating cache: \(error)")
            } else {
                print("Cache invalidated")
            }
        }
    }

    @objc
    private func centerMap() {
        mapView.setCenter(CLLocationCoordinate2D(latitude: 51.50713, longitude: -0.10957),
                          zoomLevel: 16, animated: false)
    }

    @objc
    private func setMapCenterOnSomeFarAwayLocation() {
        mapView.setCenter(CLLocationCoordinate2D(latitude: 51.450, longitude: -0.10957),
                          zoomLevel: 16, animated: false)
    }

    private func updateLocationLabel(mapView: MGLMapView) {
        locationLabel.text = "\(mapView.centerCoordinate.latitude), \(mapView.centerCoordinate.longitude)"
    }
}

extension DefaultStylesExample_Swift: MGLMapViewDelegate {
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        updateLocationLabel(mapView: mapView)
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        updateLocationLabel(mapView: mapView)
    }
}
