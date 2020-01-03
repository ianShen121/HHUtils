//
//  HHProtocol.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardLoadable{}
public protocol NibLoadable{}
public protocol RegistCellFromNib{}


public extension StoryboardLoadable where Self:UIViewController {
    static func loadStoryboard()->Self{
        return UIStoryboard(name: "\(self)", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
        
    }
    
}


public extension NibLoadable where Self:UIView{
    
    static func loadNib()->Self{
        return  Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
    
}


public extension RegistCellFromNib{
    static var identifier: String { return "\(self)" }
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
}



public extension UITableView{
    func registerCell<T: UITableViewCell>(cell: T.Type) where T: RegistCellFromNib {

          if let nib = T.nib {
            
            register(nib, forCellReuseIdentifier: T.identifier)
            
          }else { register(cell, forCellReuseIdentifier: T.identifier) }
      }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegistCellFromNib {

        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T

    }

    
    
}


public extension UICollectionView{
    
    /// 注册 cell 的方法

    func registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegistCellFromNib {

        if let nib = T.nib { register(nib, forCellWithReuseIdentifier: T.identifier) }

        else { register(cell, forCellWithReuseIdentifier: T.identifier) }

    }

    

    /// 从缓存池池出队已经存在的 cell

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegistCellFromNib {

        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T

    }

    

    /// 注册头部

    func registerSupplementaryHeaderView<T: UICollectionReusableView>(reusableView: T.Type) where T: RegistCellFromNib {

        // T 遵守了 RegisterCellOrNib 协议，所以通过 T 就能取出 identifier 这个属性

        if let nib = T.nib {

            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)

        } else {

            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)

        }

    }

    
    ///注册底部
    func registerSupplementaryFootterView<T: UICollectionReusableView>(reusableView: T.Type) where T: RegistCellFromNib {

          // T 遵守了 RegisterCellOrNib 协议，所以通过 T 就能取出 identifier 这个属性

          if let nib = T.nib {

              register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)

          } else {

              register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)

          }

      }
    
    func dequeueReusableSupplementaryFootterView<T: UICollectionReusableView>(indexPath: IndexPath) -> T where T: RegistCellFromNib {

        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier, for: indexPath) as! T

    }

    /// 获取可重用的头部

    func dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) -> T where T: RegistCellFromNib {

        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T

    }
    
    
}
