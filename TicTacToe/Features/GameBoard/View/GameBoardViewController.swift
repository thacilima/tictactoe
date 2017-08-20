//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    fileprivate let presenter = GameBoardPresenter()
    fileprivate var positions: [Position] = []
    
    fileprivate let gameBoardPadding: CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(view: self)
        presenter.startGame()
    }
}

extension GameBoardViewController: GameBoardView {
    
    func isCollectionUserInteractionEnabled(isEnabled: Bool) {
        collectionView.isUserInteractionEnabled = isEnabled
        
        if isEnabled {
            self.view.backgroundColor = UIColor.gray
        }
        else {
            self.view.backgroundColor = UIColor.red
        }
    }
    
    func setPositions(positions: [Position]) {
        self.positions = positions
        collectionView.reloadData()
    }
    
    func updatePosition(position: Position, atIndex index: Int) {
        positions[index] = position
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
}

extension GameBoardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return positions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicTacToePositionCell", for: indexPath) as! TicTacToeCollectionViewCell
        
        let position = positions[indexPath.row]
        
        if let playerOwner = position.playerOwner {
            switch playerOwner {
            case .X:
                cell.fillWithX()
            default:
                cell.fillWithO()
            }
        }
        
        return cell
    }
}

extension GameBoardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isCollectionUserInteractionEnabled(isEnabled: false)
        presenter.performUserPlay(position: positions[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 3
        
        let paddingSpace = gameBoardPadding * (itemsPerRow-1)
        let availableWidth = collectionView.frame.size.width - paddingSpace
        let size = availableWidth/itemsPerRow
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return gameBoardPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return gameBoardPadding
    }
}
